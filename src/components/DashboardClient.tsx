import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import TierSelector from './TierSelector'
import SubscriptionManager from './SubscriptionManager'
import OrderHistory from './OrderHistory'

interface Profile {
  id: string;
  user_id: string;
  email: string;
  first_name: string | null;
  created_at: string;
  merch_preferences: string[] | null;
}

interface Subscription {
  id: number;
  user_id: string;
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

        // Fetch profile
        const { data: profileData, error: profileError } = await supabase
          .from('rbhc-table-profiles')
          .select('*')
          .eq('user_id', user.id)
          .single()

        if (profileData) {
          setProfile(profileData)
          setEditName(profileData.first_name || '')
          setEditMerch(profileData.merch_preferences || [])
        }

        // Fetch subscription
        const { data: subData, error: subError } = await supabase
          .from('subscriptions')
          .select('*')
          .eq('user_id', user.id)
          .single()

        if (subData) {
          // Fetch tier separately to avoid RLS join issues
          const { data: tierData } = await supabase
            .from('subscription_tiers')
            .select('*')
            .eq('id', subData.tier_id)
            .single()

          const formattedSub = {
            ...subData,
            subscription_tiers: tierData
          } as Subscription
          setSubscription(formattedSub)
        }


        // Fetch orders with items
        const { data: orderData, error: orderError } = await supabase
          .from('orders')
          .select(`
            id,
            status,
            tracking_number,
            created_at,
            shipped_at,
            delivered_at,
            order_items (
              id,
              quantity,
              price_paid,
              product_id
            )
          `)
          .eq('user_id', user.id)
          .order('created_at', { ascending: false })

        // Fetch products separately
        const { data: productsData } = await supabase
          .from('products')
          .select('*')

        // Map product data to order items
        if (orderData && productsData) {
          const enrichedOrders = orderData.map(order => ({
            ...order,
            order_items: order.order_items.map(item => ({
              ...item,
              products: productsData.find(p => p.id === item.product_id)
            }))
          }))
          setOrders(enrichedOrders)
        }
      } catch (err) {
        console.error('Error loading user data:', err)
      } finally {
        setLoading(false)
      }
    }

    loadUserData()
  }, [])

  const handleSaveProfile = async () => {
    if (!profile) return
    setSaveLoading(true)
    setMessage(null)

    try {
      const { error } = await supabase
        .from('rbhc-table-profiles')
        .update({
          first_name: editName || null,
          merch_preferences: editMerch.length > 0 ? editMerch : null
        })
        .eq('id', profile.id)

      if (error) throw error

      setProfile({ ...profile, first_name: editName, merch_preferences: editMerch })
      setEditingProfile(false)
      setMessage({ type: 'success', text: 'Profile updated successfully!' })
      setTimeout(() => setMessage(null), 3000)
    } catch (err) {
      const errorMsg = err instanceof Error ? err.message : 'Failed to update profile'
      setMessage({ type: 'error', text: errorMsg })
    } finally {
      setSaveLoading(false)
    }
  }

  const handleUpgrade = async (tierId: number, billingCycle: number) => {
    try {
      // TODO: Redirect to Stripe checkout
      console.log('Upgrade to tier:', tierId, 'cycle:', billingCycle)
      setMessage({ type: 'success', text: 'Stripe checkout coming soon!' })
    } catch (err) {
      setMessage({ type: 'error', text: 'Upgrade failed' })
    }
  }

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    window.location.href = '/'
  }

  if (loading) {
    return (
      <div className="card text-center py-12">
        <p className="text-[var(--color-text-secondary)]">Loading dashboard...</p>
      </div>
    )
  }

  if (!profile || !subscription) {
    return (
      <div className="card text-center py-12">
        <p className="text-red-600">Error loading dashboard data</p>
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
    <div className="space-y-6">
      {/* Welcome Header */}
      <div className="card">
        <h1 className="text-3xl font-bold text-[var(--color-primary)] mb-2">
          Welcome back, {profile.first_name || 'Friend'}!
        </h1>
        <p className="text-[var(--color-text-secondary)]">
          Member since {new Date(profile.created_at).toLocaleDateString()}
        </p>
      </div>

      {/* Message Toast */}
      {message && (
        <div className={`p-4 rounded-lg ${
          message.type === 'success' 
            ? 'bg-green-100 text-green-800' 
            : 'bg-red-100 text-red-800'
        }`}>
          {message.text}
        </div>
      )}

      {/* Tabs */}
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

      {/* Tab Content */}
      <div>
        {/* Subscription Tab */}
        {activeTab === 'subscription' && subscription && (
          <SubscriptionManager subscription={subscription} />
        )}

        {/* Upgrade Tab */}
        {activeTab === 'upgrade' && (
          <TierSelector 
            currentTierName={subscription.subscription_tiers.name}
            onUpgrade={handleUpgrade}
          />
        )}

        {/* Profile Tab */}
        {activeTab === 'profile' && (
          <div className="card space-y-4">
            {editingProfile ? (
              <div className="space-y-4">
                <h3 className="text-xl font-bold text-[var(--color-text-primary)]">Edit Profile</h3>
                
                <div>
                  <label className="form-label">Email</label>
                  <input
                    type="email"
                    value={profile.email}
                    disabled
                    className="form-input opacity-50 cursor-not-allowed"
                  />
                  <p className="text-xs text-[var(--color-text-secondary)] mt-1">Email cannot be changed</p>
                </div>

                <div>
                  <label className="form-label">First Name</label>
                  <input
                    type="text"
                    value={editName}
                    onChange={e => setEditName(e.target.value)}
                    maxLength={50}
                    className="form-input"
                  />
                </div>

                <div>
                  <label className="form-label">Merchandise Preferences</label>
                  <div className="space-y-2">
                    {['shirt', 'hat'].map(merch => (
                      <label key={merch} className="flex items-center gap-2 cursor-pointer">
                        <input
                          type="checkbox"
                          checked={editMerch.includes(merch)}
                          onChange={e => {
                            if (e.target.checked) {
                              setEditMerch([...editMerch, merch])
                            } else {
                              setEditMerch(editMerch.filter(m => m !== merch))
                            }
                          }}
                          className="w-4 h-4"
                        />
                        <span className="capitalize">{merch}</span>
                      </label>
                    ))}
                  </div>
                </div>

                <div className="flex gap-3">
                  <button
                    onClick={() => {
                      setEditingProfile(false)
                      setEditName(profile.first_name || '')
                      setEditMerch(profile.merch_preferences || [])
                    }}
                    className="flex-1 px-4 py-2 border rounded-lg hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={handleSaveProfile}
                    disabled={saveLoading}
                    className="flex-1 btn btn-primary disabled:opacity-50"
                  >
                    {saveLoading ? 'Saving...' : 'Save Changes'}
                  </button>
                </div>
              </div>
            ) : (
              <div className="space-y-4">
                <h3 className="text-xl font-bold text-[var(--color-text-primary)]">Profile Information</h3>
                
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div>
                    <p className="text-[var(--color-text-secondary)] text-xs uppercase">Email</p>
                    <p className="font-semibold">{profile.email}</p>
                  </div>
                  <div>
                    <p className="text-[var(--color-text-secondary)] text-xs uppercase">First Name</p>
                    <p className="font-semibold">{profile.first_name || 'Not set'}</p>
                  </div>
                  {profile.merch_preferences && profile.merch_preferences.length > 0 && (
                    <div className="col-span-2">
                      <p className="text-[var(--color-text-secondary)] text-xs uppercase">Merch Preferences</p>
                      <p className="font-semibold capitalize">{profile.merch_preferences.join(', ')}</p>
                    </div>
                  )}
                </div>
                
                <button
                  onClick={() => setEditingProfile(true)}
                  className="btn btn-secondary"
                >
                  Edit Profile
                </button>
              </div>
            )}
          </div>
        )}

        {/* Orders Tab */}
        {activeTab === 'orders' && (
          <OrderHistory orders={orders} />
        )}

        {/* Settings Tab */}
        {activeTab === 'settings' && (
          <div className="card space-y-4">
            <h3 className="text-xl font-bold text-[var(--color-text-primary)]">Account Settings</h3>
            
            <div className="border-t border-gray-200 pt-4">
              <button
                onClick={handleSignOut}
                className="w-full px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors"
              >
                Sign Out
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}