import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import TierSelector from './TierSelector'
import SubscriptionManager from './SubscriptionManager'
import OrderHistory from './OrderHistory'

interface Profile {
  id: number; 
  user_id: string;
  email: string;
  first_name: string;
  created_at: string;
  merch_preferences: string[] | null;
}

interface Subscription {
  id: number;
  profile_id: number; 
  tier_id: number;
  stripe_customer_id: string | null;
  stripe_subscription_id: string | null;
  billing_cycle: number;
  status: string;
  next_renewal_date: string | null;
  created_at: string;
  subscription_tiers: {
    name: string;
    display_name: string;
  };
}

interface Order {
  id: number;
  profile_id: number; 
  status: string;
  tracking_number: string | null;
  created_at: string;
  shipped_at: string | null;
  delivered_at: string | null;
  order_items: any[];
}

type TabType = 'profile' | 'subscription' | 'upgrade' | 'orders'

export default function DashboardClient() {
  const [profile, setProfile] = useState<Profile | null>(null)
  const [subscription, setSubscription] = useState<Subscription | null>(null)
  const [orders, setOrders] = useState<Order[]>([])
  const [loading, setLoading] = useState(true)
  const [activeTab, setActiveTab] = useState<TabType>('subscription')
  const [isMobile, setIsMobile] = useState(false)
  
  const [editingProfile, setEditingProfile] = useState(false)
  const [editName, setEditName] = useState('')
  
  const [saveLoading, setSaveLoading] = useState(false)
  const [message, setMessage] = useState<{ type: string; text: string } | null>(null)
  const [savingMerch, setSavingMerch] = useState<string | null>(null)

  // Detect mobile
  useEffect(() => {
    const checkMobile = () => setIsMobile(window.innerWidth < 768);
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  const loadUserData = async () => {
    setLoading(true)
    try {
      const { data: { user }, error: authError } = await supabase.auth.getUser()
      
      if (authError || !user) {
        window.location.href = '/signin'
        return; 
      }

      const { data: profileData, error: profileError } = await supabase
        .from('rbhc-table-profiles')
        .select('*')
        .eq('user_id', user.id)
        .maybeSingle()

      if (profileError || !profileData) {
        console.error('Profile Error:', profileError)
        setLoading(false)
        return
      }

      setProfile(profileData)
      setEditName(profileData.first_name || '')

      const [subResponse, orderResponse] = await Promise.all([
        supabase
          .from('subscriptions')
          .select(`*, subscription_tiers:tier_id (name, display_name)`)
          .eq('profile_id', profileData.id)
          .maybeSingle(),
        supabase
          .from('orders')
          .select(`*, order_items (*, products (*))`)
          .eq('profile_id', profileData.id)
          .order('created_at', { ascending: false })
      ])

      if (subResponse.data) {
        const tier = Array.isArray(subResponse.data.subscription_tiers) 
          ? subResponse.data.subscription_tiers[0] 
          : subResponse.data.subscription_tiers;

        setSubscription({
          ...subResponse.data,
          subscription_tiers: tier
        } as Subscription)
      }

      if (orderResponse.data) {
        setOrders(orderResponse.data)
      }

    } catch (err) {
      console.error('Critical Dashboard Error:', err)
      setLoading(false)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    loadUserData()
  }, [])

  useEffect(() => {
    if (editingProfile && profile) {
      setEditName(profile.first_name);
    }
  }, [editingProfile]);

  const handleSaveProfile = async () => {
    if (!profile) return
    setSaveLoading(true)
    setMessage(null)

    try {
      const { error } = await supabase
        .from('rbhc-table-profiles')
        .update({
          first_name: editName
        })
        .eq('id', profile.id)

      if (error) throw error

      setProfile({ ...profile, first_name: editName })
      setEditingProfile(false)
      setMessage({ type: 'success', text: 'Profile updated successfully!' })
      setTimeout(() => setMessage(null), 3000)
    } catch (err) {
      setMessage({ type: 'error', text: 'Update failed. Please check your connection.' })
    } finally {
      setSaveLoading(false)
    }
  }

  const handleMerchToggle = async (item: string) => {
    if (!profile) return
    setSavingMerch(item)

    const currentPrefs = profile.merch_preferences || []
    const newMerchPrefs = currentPrefs.includes(item)
      ? currentPrefs.filter(i => i !== item)
      : [...currentPrefs, item]

    try {
      const { error } = await supabase
        .from('rbhc-table-profiles')
        .update({ merch_preferences: newMerchPrefs })
        .eq('id', profile.id)

      if (error) throw error

      setProfile({ ...profile, merch_preferences: newMerchPrefs })
    } catch (err) {
      console.error('Failed to update merch preferences:', err)
    } finally {
      setSavingMerch(null)
    }
  }

  // RENDER LOGIC
  if (loading) {
    return (
      <div className="max-w-4xl mx-auto px-4 py-12 text-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-[var(--color-secondary)] mx-auto mb-4"></div>
        <p className="text-[var(--color-text-secondary)]">Syncing your dashboard...</p>
      </div>
    )
  }

  if (!profile) {
    return (
      <div className="max-w-4xl mx-auto px-4 py-12 text-center card">
        <p className="text-red-600 mb-4">We couldn't find your member profile.</p>
        <button onClick={() => window.location.href = '/signin'} className="btn btn-primary">
          Back to Sign In
        </button>
      </div>
    )
  }

  // Tab list - NO SETTINGS
  const tabList: { id: TabType; label: string; icon?: string }[] = [
    { id: 'subscription', label: 'Subscription', icon: '🐝' },
    { id: 'upgrade', label: 'Upgrade Tier', icon: '⬆️' },
    { id: 'profile', label: 'Profile', icon: '👤' },
    { id: 'orders', label: 'Orders', icon: '📦' }
  ]

  return (
    <div className="px-4 py-8 space-y-6">
      {/* Dashboard Header - Constrained to max-w-4xl */}
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Welcome Card */}
        <div className="card card-grow-in bg-gradient-to-r from-[var(--color-primary)]/10 via-[var(--color-accent)]/10 to-[var(--color-secondary)]/10 border border-[var(--color-accent)]/20">
          <h1 className="text-3xl sm:text-4xl font-bold text-[var(--color-primary)] mb-2">
            Welcome back, {profile.first_name}!
          </h1>
          <p className="text-[var(--color-text-secondary)] text-sm sm:text-base">
            Member since {new Date(profile.created_at).toLocaleDateString()} • Email: <span className="font-semibold">{profile.email}</span>
          </p>
        </div>

        {message && (
          <div className={`p-4 rounded-lg border ${
            message.type === 'success' 
              ? 'bg-green-50 text-green-800 border-green-200' 
              : 'bg-red-50 text-red-800 border-red-200'
        }`}>
            {message.text}
          </div>
        )}

        {/* Tab Navigation */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-1 pb-2 border-b-2 border-[var(--color-accent)]/20">
          {tabList.map(tab => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`px-2 sm:px-4 py-3 font-semibold border-b-4 transition-all text-xs sm:text-sm text-center ${
                activeTab === tab.id
                  ? 'border-b-[var(--color-secondary)] text-[var(--color-secondary)]'
                  : 'border-b-transparent text-[var(--color-text-secondary)] hover:text-[var(--color-primary)]'
              }`}
            >
              <span className="block sm:inline">{tab.icon} </span><span className="hidden sm:inline">{tab.label}</span><span className="sm:hidden text-xs">{tab.label.split(' ')[0]}</span>
            </button>
          ))}
        </div>
      </div>

      {/* Tab Content - Conditional Width */}
      {activeTab === 'upgrade' ? (
        // Tier Selector - Full Width with Enhanced Spacing
        <div className="py-4">
          <TierSelector 
            currentTierName={subscription?.subscription_tiers?.name || 'None'}
            onUpgrade={(tierId, cycle) => console.log('Upgrade:', tierId, cycle)}
          />
        </div>
      ) : (
        // Other Content - Constrained Width
        <div className="max-w-4xl mx-auto">
          {activeTab === 'subscription' && (
            subscription ? (
              <SubscriptionManager subscription={subscription} />
            ) : (
              <div className="card text-center py-12 bg-gradient-to-b from-[var(--color-accent)]/5 to-[var(--color-secondary)]/5 border border-[var(--color-accent)]/20">
                <p className="text-lg mb-6 text-[var(--color-text-primary)] font-semibold">You don't have an active subscription yet.</p>
                <button onClick={() => setActiveTab('upgrade')} className="btn btn-primary">Explore Membership Plans</button>
              </div>
            )
          )}

          {activeTab === 'profile' && (
            <div className="card space-y-6">
              {editingProfile ? (
                <div className="space-y-4">
                  <h3 className="text-xl font-bold">Edit Profile</h3>
                  <div>
                    <label className="block text-sm font-medium mb-1">Email (Immutable)</label>
                    <input type="email" value={profile.email} disabled className="form-input bg-gray-50 opacity-70 cursor-not-allowed w-full" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium mb-1">First Name</label>
                    <input 
                      type="text" 
                      value={editName} 
                      onChange={e => setEditName(e.target.value)} 
                      className="form-input w-full" 
                      placeholder="Enter your name"
                    />
                  </div>
                  <p className="text-sm text-[var(--color-text-secondary)] bg-[var(--color-accent)]/5 p-3 rounded-lg border border-[var(--color-accent)]/20">
                    💡 Tip: Update your merch preferences directly in the "Your Merch Preferences" section below—changes save instantly!
                  </p>
                  <div className="flex gap-3 pt-4 flex-col sm:flex-row">
                    <button onClick={() => setEditingProfile(false)} className="flex-1 py-2 border rounded-lg hover:bg-gray-50">Cancel</button>
                    <button onClick={handleSaveProfile} disabled={saveLoading} className="flex-1 btn btn-primary">
                      {saveLoading ? 'Saving...' : 'Save Changes'}
                    </button>
                  </div>
                </div>
              ) : (
                <div className="space-y-6">
                  <div className="flex justify-between items-center flex-col sm:flex-row gap-4">
                    <h3 className="text-xl font-bold">Profile Details</h3>
                    <button onClick={() => setEditingProfile(true)} className="text-[var(--color-secondary)] font-semibold hover:underline">Edit Profile</button>
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div className="p-4 bg-[var(--color-accent)]/5 rounded-lg border border-[var(--color-accent)]/20">
                      <p className="text-xs uppercase text-[var(--color-text-secondary)] font-bold mb-2">Email Address</p>
                      <p className="text-lg font-semibold text-[var(--color-text-primary)]">{profile.email}</p>
                    </div>
                    <div className="p-4 bg-[var(--color-secondary)]/5 rounded-lg border border-[var(--color-secondary)]/20">
                      <p className="text-xs uppercase text-[var(--color-text-secondary)] font-bold mb-2">First Name</p>
                      <p className="text-lg font-semibold text-[var(--color-text-primary)]">{profile.first_name || 'Not set'}</p>
                    </div>
                  </div>
                  <div className="pt-4 border-t">
                    <p className="text-xs uppercase text-[var(--color-text-secondary)] font-bold mb-3">Your Merch Preferences</p>
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                      {['T-Shirts', 'Hoodies', 'Hats', 'Stickers'].map((item) => (
                        <button
                          key={item}
                          type="button"
                          onClick={() => handleMerchToggle(item)}
                          disabled={savingMerch !== null}
                          className={`p-4 border-2 rounded-lg font-semibold transition-all duration-300 text-center relative ${
                            profile.merch_preferences?.includes(item)
                              ? 'border-[var(--color-secondary)] bg-[var(--color-secondary)]/10 text-[var(--color-secondary)] shadow-lg shadow-[var(--color-secondary)]/50'
                              : 'border-[var(--color-accent)]/30 bg-white text-[var(--color-text-primary)] hover:border-[var(--color-secondary)]/50 hover:bg-[var(--color-accent)]/5'
                          } ${savingMerch === item ? 'opacity-60' : ''}`}
                        >
                          {savingMerch === item && (
                            <span className="absolute inset-0 flex items-center justify-center">
                              <span className="animate-spin rounded-full h-4 w-4 border-2 border-[var(--color-secondary)]/30 border-t-[var(--color-secondary)]"></span>
                            </span>
                          )}
                          <span className={savingMerch === item ? 'opacity-0' : ''}>
                            {profile.merch_preferences?.includes(item) && <span className="mr-2">✨</span>}
                            {item}
                          </span>
                        </button>
                      ))}
                    </div>
                  </div>
                </div>
              )}
            </div>
          )}

          {activeTab === 'orders' && <OrderHistory orders={orders} />}
        </div>
      )}
    </div>
  )
}