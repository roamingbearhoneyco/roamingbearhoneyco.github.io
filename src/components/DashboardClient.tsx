import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';

export default function DashboardClient() {
  const [email, setEmail] = useState<string | null>(null);
  const [uuid, setUuid] = useState<string | null>(null);
  const [tier, setTier] = useState<string | null>(null);
  const [createdAt, setCreatedAt] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const getUser = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      
      if (!user) {
        // Redirect to signin if not authenticated
        window.location.href = '/signin';
        return;
      }

      setEmail(user.email ?? null);
      setUuid(user.id);
      
      // Fetch user profile data
      const { data: profile } = await supabase
        .from('rbhc-table-profiles')
        .select('subscription_tier, created_at')
        .eq('user_id', user.id)
        .single();
      
      if (profile) {
        setTier(profile.subscription_tier ?? null);
        setCreatedAt(profile.created_at ?? null);
      }
      
      setLoading(false);
    };

    getUser();
  }, []);

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    window.location.href = '/';
  };

  if (loading) {
    return (
      <div className="card max-w-xl mx-auto text-center">
        <p className="text-[var(--color-text-secondary)]">Loading...</p>
      </div>
    );
  }

  return (
    <div className="card max-w-xl mx-auto space-y-6">
      <div className="text-center">
        <h1 className="text-2xl font-bold text-[var(--color-primary)]">
          {email ? 'Welcome back!' : 'Loading...'}
        </h1>
        {email && <p className="text-sm text-[var(--color-text-secondary)] mt-1">{email}</p>}
      </div>

      {uuid && (
        <div className="bg-[var(--color-background)] border border-[var(--color-accent)]/20 rounded-[var(--radius-md)] p-4 text-sm text-[var(--color-text-secondary)] space-y-2">
          <div>
            <span className="font-medium text-[var(--color-text-primary)]">UUID:</span>{' '}
            <span className="break-all">{uuid}</span>
          </div>
          <div>
            <span className="font-medium text-[var(--color-text-primary)]">Subscription Tier:</span>{' '}
            <span>{tier ?? 'N/A'}</span>
          </div>
          <div>
            <span className="font-medium text-[var(--color-text-primary)]">Account Created:</span>{' '}
            <span>{createdAt ? new Date(createdAt + 'Z').toLocaleString(undefined, {
              dateStyle: 'medium',
              timeStyle: 'short',
            }
            ) : 'N/A'}</span>
          </div>
        </div>
      )}

      <p className="text-[var(--color-text-secondary)] text-center">
        Thanks for supporting Roaming Bear Honey Co 🍯
      </p>

      <button
        id="signout"
        onClick={handleSignOut}
        className="btn btn-secondary w-full"
      >
        Sign Out
      </button>
    </div>
  );
}
