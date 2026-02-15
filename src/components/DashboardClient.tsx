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

type TabType = 'profile' | 'subscription' | 'upgrade' | 'orders' | 'settings'

export default function DashboardClient() {
  const [profile, setProfile] = useState<Profile | null>(null)
  const [subscription, setSubscription] = useState<Subscription | null>(null)
  const [orders, setOrders] = useState<Order[]>([])
  const [loading, setLoading] = useState(true)
  const [activeTab, setActiveTab] = useState<TabType>('subscription')
  
  const [editingProfile, setEditingProfile] = useState(false)
  const [editName, setEditName] = useState('')
  const [editMerch, setEditMerch] = useState<string[]>([])
  
  const [saveLoading, setSaveLoading] = useState(false)
  const [message, setMessage] = useState<{ type: string; text: string } | null>(null)

  const loadUserData = async () => {
    setLoading(true)
    try {
      // --- PHASE 1: THE BOUNCER (AUTH CHECK) ---
      const { data: { user }, error: authError } = await supabase.auth.getUser()
      
      if (authError || !user) {
        // Redirecting immediately.
        window.location.href = '/signin'
        // We return a "hanging" promise here so that 'loading' stays true.
        // This prevents the "Red Error" UI from ever rendering before the page changes.
        return; 
      }

      // --- PHASE 2: THE FETCHER (Only runs if logged in) ---
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
      setEditMerch(profileData.merch_preferences || [])

      // Fetch related data in parallel
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
      // This only runs if we didn't trigger the redirect return above
      setLoading(false)
    }
  }

  useEffect(() => {
    loadUserData()
  }, [])

  useEffect(() => {
    if (profile) {
      setEditName(profile.first_name);
      setEditMerch(profile.merch_preferences || []);
    }
  }, [editingProfile, profile]);

  const handleSaveProfile = async () => {
    if (!profile) return
    setSaveLoading(true)
    setMessage(null)

    try {
      const { error } = await supabase
        .from('rbhc-table-profiles')
        .update({
          first_name: editName,
          merch_preferences: editMerch 
        })
        .eq('id', profile.id)

      if (error) throw error

      setProfile({ ...profile, first_name: editName, merch_preferences: editMerch })
      setEditingProfile(false)
      setMessage({ type: 'success', text: 'Profile updated successfully!' })
      setTimeout(() => setMessage(null), 3000)
    } catch (err) {
      setMessage({ type: 'error', text: 'Update failed. Please check your connection.' })
    } finally {
      setSaveLoading(false)
    }
  }

  // RENDER LOGIC
  // 1. Show the spinner while checking auth OR while redirecting
  if (loading) {
    return (
      <div className="max-w-4xl mx-auto px-4 py-12 text-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-[var(--color-secondary)] mx-auto mb-4"></div>
        <p className="text-[var(--color-text-secondary)]">Syncing your dashboard...</p>
      </div>
    )
  }

  // 2. Only show this if loading is FINISHED and profile is still null
  // (This handles the case where the user is logged in but doesn't have a DB record)
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

  const tabList: { id: TabType; label: string }[] = [
    { id: 'subscription', label: 'Subscription' },
    { id: 'upgrade', label: 'Upgrade Tier' },
    { id: 'profile', label: 'Profile' },
    { id: 'orders', label: 'Orders' },
    { id: 'settings', label: 'Settings' }
  ]

  return (
    <div className="max-w-4xl mx-auto px-4 py-8 space-y-6">
      <div className="card">
        <h1 className="text-3xl font-bold text-[var(--color-primary)] mb-2">
          Welcome back, {profile.first_name}!
        </h1>
        <p className="text-[var(--color-text-secondary)]">
          Member since {new Date(profile.created_at).toLocaleDateString()}
        </p>
      </div>

      {message && (
        <div className={`p-4 rounded-lg ${
          message.type === 'success' ? 'bg-green-100 text-green-800 border border-green-200' : 'bg-red-100 text-red-800 border border-red-200'
        }`}>
          {message.text}
        </div>
      )}

      {/* Tabs */}
      <div className="flex gap-2 border-b border-gray-200 overflow-x-auto scrollbar-hide">
        {tabList.map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`px-4 py-3 font-semibold border-b-2 transition-colors whitespace-nowrap ${
              activeTab === tab.id
                ? 'border-[var(--color-secondary)] text-[var(--color-secondary)]'
                : 'border-transparent text-[var(--color-text-secondary)] hover:text-[var(--color-primary)]'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Tab Content */}
      <div className="mt-6">
        {activeTab === 'subscription' && (
          subscription ? (
            <SubscriptionManager subscription={subscription} />
          ) : (
            <div className="card text-center py-12">
               <p className="text-lg mb-6">You don't have an active subscription yet.</p>
               <button onClick={() => setActiveTab('upgrade')} className="btn btn-primary">Explore Membership Plans</button>
            </div>
          )
        )}

        {activeTab === 'upgrade' && (
          <TierSelector 
            currentTierName={subscription?.subscription_tiers?.name || 'None'}
            onUpgrade={(tierId, cycle) => console.log('Upgrade:', tierId, cycle)}
          />
        )}

        {activeTab === 'profile' && (
          <div className="card space-y-6">
            {editingProfile ? (
              <div className="space-y-4">
                <h3 className="text-xl font-bold">Edit Profile</h3>
                <div>
                  <label className="block text-sm font-medium mb-1">Email (Immutable)</label>
                  <input type="email" value={profile.email} disabled className="form-input bg-gray-50 opacity-70 cursor-not-allowed" />
                </div>
                <div>
                  <label className="block text-sm font-medium mb-1">First Name</label>
                  <input 
                    type="text" 
                    value={editName} 
                    onChange={e => setEditName(e.target.value)} 
                    className="form-input" 
                    placeholder="Enter your name"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium mb-2">Merch Preferences</label>
                  <div className="grid grid-cols-2 gap-3">
                    {['T-Shirts', 'Hoodies', 'Hats', 'Stickers'].map((item) => (
                      <label key={item} className="flex items-center p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                        <input
                          type="checkbox"
                          checked={editMerch.includes(item)}
                          onChange={(e) => {
                            setEditMerch(prev => e.target.checked ? [...prev, item] : prev.filter(i => i !== item))
                          }}
                          className="mr-3 h-4 w-4 text-[var(--color-secondary)] focus:ring-[var(--color-secondary)] border-gray-300 rounded"
                        />
                        <span className="text-sm">{item}</span>
                      </label>
                    ))}
                  </div>
                </div>
                <div className="flex gap-3 pt-4">
                  <button onClick={() => setEditingProfile(false)} className="flex-1 py-2 border rounded-lg hover:bg-gray-50">Cancel</button>
                  <button onClick={handleSaveProfile} disabled={saveLoading} className="flex-1 btn btn-primary">
                    {saveLoading ? 'Saving...' : 'Save Changes'}
                  </button>
                </div>
              </div>
            ) : (
              <div className="space-y-6">
                <div className="flex justify-between items-center">
                  <h3 className="text-xl font-bold">Profile Details</h3>
                  <button onClick={() => setEditingProfile(true)} className="text-[var(--color-secondary)] font-semibold hover:underline">Edit</button>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div>
                    <p className="text-xs uppercase text-gray-500 font-bold mb-1">Email Address</p>
                    <p className="text-lg">{profile.email}</p>
                  </div>
                  <div>
                    <p className="text-xs uppercase text-gray-500 font-bold mb-1">First Name</p>
                    <p className="text-lg">{profile.first_name}</p>
                  </div>
                </div>
                <div className="pt-4 border-t">
                  <p className="text-xs uppercase text-gray-500 font-bold mb-3">Your Merch Preferences</p>
                  <div className="flex flex-wrap gap-2">
                    {profile.merch_preferences?.length ? profile.merch_preferences.map(item => (
                      <span key={item} className="px-3 py-1 bg-[var(--color-secondary)]/10 text-[var(--color-secondary)] text-sm font-medium rounded-full border border-[var(--color-secondary)]/20">
                        {item}
                      </span>
                    )) : <p className="text-gray-400 italic">No preferences selected</p>}
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {activeTab === 'orders' && <OrderHistory orders={orders} />}

        {activeTab === 'settings' && (
          <div className="card border-red-100">
            <h3 className="text-xl font-bold mb-4">Account Settings</h3>
            <button 
              onClick={() => supabase.auth.signOut().then(() => window.location.href = '/')} 
              className="w-full px-4 py-3 bg-red-600 text-white rounded-lg font-bold hover:bg-red-700 transition-colors"
            >
              Sign Out of RBHC
            </button>
          </div>
        )}
      </div>
    </div>
  )
}