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

      // Query rbhc-table-profiles for subscription data
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
    <div className="max-w-md mx-auto bg-white border border-gray-200 shadow-md rounded p-6 space-y-6 text-center">
      <h1 className="text-xl font-bold text-[#19360e]">
        {email ? `Welcome ${email}` : 'Loading...'}
      </h1>

      {uuid && (
        <div className="space-y-1 text-left text-sm text-gray-800 mt-4">
          <p><strong>UUID:</strong> {uuid}</p>
          <p><strong>Tier:</strong> {tier ?? 'Free'}</p>
          <p><strong>Created:</strong> {createdAt ? new Date(createdAt).toLocaleString() : 'N/A'}</p>
        </div>
      )}

      <p className="text-sm text-gray-700">We’re happy to see you here 🍯</p>

      <button
        id="signout"
        onClick={handleSignOut}
        className="w-full bg-[#a05d35] text-white py-2 px-4 rounded hover:bg-[#8c4c29] transition-colors font-semibold"
      >
        Sign out
      </button>
    </div>
  );
}
