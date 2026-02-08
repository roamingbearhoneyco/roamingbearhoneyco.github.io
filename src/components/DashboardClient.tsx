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

  useEffect(() => {
    const loadUserData = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser()
        if (!user) {
          window.location.href = '/signin'
          return
        }

        const { data: profileData, error: profileError } = await supabase
          .from('rbhc-table-profiles')
          .select('*')
          .eq('user_id', user.id)
          .single()

        if (profileError || !profileData) {
          setLoading(false)
          return
        }

        setProfile(profileData)
        setEditName(profileData.first_name || '')
        setEditMerch(profileData.merch_preferences || [])

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
        console.error('Error loading user data:', err)
      } finally {
        setLoading(false)
      }
    }
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
      // DB handles the "Friend" default and "First Name" splitting
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
      setMessage({ type: 'error', text: 'Failed to update profile' })
    } finally {
      setSaveLoading(false)
    }
  }

  // ... (rest of the component: handleUpgrade, handleSignOut, Loading/Error screens)

  const tabList: { id: TabType; label: string }[] = [
    { id: 'subscription', label: 'Subscription' },
    { id: 'upgrade', label: 'Upgrade Tier' },
    { id: 'profile', label: 'Profile' },
    { id: 'orders', label: 'Orders' },
    { id: 'settings', label: 'Settings' }
  ]

  return (
    <div className="space-y-6">
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
          message.type === 'success' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
        }`}>
          {message.text}
        </div>
      )}

      <div className="flex gap-2 border-b border-gray-200 overflow-x-auto">
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

      <div>
        {activeTab === 'subscription' && (
          subscription ? (
            <SubscriptionManager subscription={subscription} />
          ) : (
            <div className="card text-center py-8">
               <p className="mb-4">No active subscription found.</p>
               <button onClick={() => setActiveTab('upgrade')} className="btn btn-primary">Choose a Plan</button>
            </div>
          )
        )}

        {activeTab === 'upgrade' && (
          <TierSelector 
            currentTierName={subscription?.subscription_tiers?.name || 'None'}
            onUpgrade={handleUpgrade}
          />
        )}

        {activeTab === 'profile' && (
          <div className="card space-y-4">
            {editingProfile ? (
              <div className="space-y-4">
                <h3 className="text-xl font-bold text-[var(--color-text-primary)]">Edit Profile</h3>
                <div>
                  <label className="form-label">Email</label>
                  <input type="email" value={profile.email} disabled className="form-input opacity-50 cursor-not-allowed" />
                </div>
                <div>
                  <label className="form-label">First Name</label>
                  <input 
                    type="text" 
                    value={editName} 
                    onChange={e => setEditName(e.target.value)} 
                    className="form-input" 
                  />
                </div>
                
                <div>
                  <label className="form-label mb-2 block">Merch Preferences</label>
                  <div className="grid grid-cols-2 gap-2">
                    {['T-Shirts', 'Hoodies', 'Hats', 'Stickers'].map((item) => (
                      <label key={item} className="flex items-center space-x-2 p-3 border rounded-lg cursor-pointer hover:bg-gray-50 transition-colors">
                        <input
                          type="checkbox"
                          checked={editMerch.includes(item)}
                          onChange={(e) => {
                            if (e.target.checked) {
                              setEditMerch([...editMerch, item])
                            } else {
                              setEditMerch(editMerch.filter(i => i !== item))
                            }
                          }}
                          className="rounded border-gray-300 text-[var(--color-secondary)] focus:ring-[var(--color-secondary)]"
                        />
                        <span className="text-sm font-medium">{item}</span>
                      </label>
                    ))}
                  </div>
                </div>

                <div className="flex gap-3">
                  <button onClick={() => setEditingProfile(false)} className="flex-1 px-4 py-2 border rounded-lg">Cancel</button>
                  <button onClick={handleSaveProfile} disabled={saveLoading} className="flex-1 btn btn-primary">
                    {saveLoading ? 'Saving...' : 'Save Changes'}
                  </button>
                </div>
              </div>
            ) : (
              <div className="space-y-4">
                <h3 className="text-xl font-bold text-[var(--color-text-primary)]">Profile Information</h3>
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div>
                    <p className="text-xs uppercase text-[var(--color-text-secondary)]">Email</p>
                    <p className="font-semibold">{profile.email}</p>
                  </div>
                  <div>
                    <p className="text-xs uppercase text-[var(--color-text-secondary)]">First Name</p>
                    <p className="font-semibold">{profile.first_name}</p>
                  </div>
                </div>

                <div className="mt-2 pt-4 border-t border-gray-100">
                  <p className="text-xs uppercase text-[var(--color-text-secondary)] mb-2">Merch Preferences</p>
                  <div className="flex flex-wrap gap-2">
                    {profile.merch_preferences && profile.merch_preferences.length > 0 ? (
                      profile.merch_preferences.map(item => (
                        <span key={item} className="px-3 py-1 bg-[var(--color-secondary)]/10 text-[var(--color-secondary)] text-xs font-bold rounded-full border border-[var(--color-secondary)]/20">
                          {item}
                        </span>
                      ))
                    ) : (
                      <p className="text-sm italic text-gray-400">No preferences set</p>
                    )}
                  </div>
                </div>

                <button onClick={() => setEditingProfile(true)} className="btn btn-secondary mt-4">Edit Profile</button>
              </div>
            )}
          </div>
        )}

        {activeTab === 'orders' && <OrderHistory orders={orders} />}

        {activeTab === 'settings' && (
          <div className="card">
            <button onClick={() => supabase.auth.signOut().then(() => window.location.href = '/')} className="w-full px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors">
              Sign Out
            </button>
          </div>
        )}
      </div>
    </div>
  )
}