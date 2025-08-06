import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';

export default function DashboardClient() {
  const [email, setEmail] = useState<string | null>(null);
  const [uuid, setUuid] = useState<string | null>(null);
  const [tier, setTier] = useState<string | null>(null);
  const [createdAt, setCreatedAt] = useState<string | null>(null);

  useEffect(() => {
    const fetchUserData = async () => {
      const { data: { session }, error } = await supabase.auth.getSession();

      if (!session || !session.user) {
        window.location.href = '/signin';
        return;
      }

      const user = session.user;
      setEmail(user.email ?? null);
      setUuid(user.id);

      const { data: profileData, error: profileError } = await supabase
        .from('rbhc-table-profiles')
        .select('subscription_tier, created_at')
        .eq('user_id', user.id)
        .single();

      if (!profileError && profileData) {
        setTier(profileData.subscription_tier);
        setCreatedAt(profileData.created_at);
      } else {
        console.error('❌ Error fetching user profile:', profileError);
      }
    };

    fetchUserData();
  }, []);

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    window.location.href = '/signin';
  };

  return (
    <div className="max-w-xl mx-auto mt-10 p-6 bg-white border border-gray-200 shadow-xl rounded-lg space-y-6">
      <div className="text-center">
        <h1 className="text-2xl font-bold text-[#19360e]">
          {email ? 'Welcome back!' : 'Loading...'}
        </h1>
        {email && <p className="text-sm text-gray-600 mt-1">{email}</p>}
      </div>

      {uuid && (
        <div className="bg-gray-50 border border-gray-200 rounded-md p-4 text-sm text-gray-800 space-y-2">
          <div>
            <span className="font-medium text-gray-700">UUID:</span>{' '}
            <span className="break-all">{uuid}</span>
          </div>
          <div>
            <span className="font-medium text-gray-700">Subscription Tier:</span>{' '}
            <span>{tier ?? 'Free'}</span>
          </div>
          <div>
            <span className="font-medium text-gray-700">Account Created:</span>{' '}
            <span>{createdAt ? new Date(createdAt).toLocaleString() : 'N/A'}</span>
          </div>
        </div>
      )}

      <p className="text-sm text-gray-600 text-center">
        Thanks for supporting Roaming Bear Honey Co 🍯
      </p>

      <button
        id="signout"
        onClick={handleSignOut}
        className="w-full bg-[#a05d35] text-white py-2 px-4 rounded hover:bg-[#8c4c29] transition-colors font-semibold"
      >
        Sign Out
      </button>
    </div>
  );
}
