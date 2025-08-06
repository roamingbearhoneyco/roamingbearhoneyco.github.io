// src/components/DashboardClient.tsx
import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';

export default function DashboardClient() {
  const [email, setEmail] = useState<string | null>(null);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        window.location.href = '/signin';
      } else {
        setEmail(session.user.email ?? null);
      }
    });
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
