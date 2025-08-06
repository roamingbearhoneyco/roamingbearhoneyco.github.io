// src/components/Confirm.tsx
import { useEffect } from 'react';
import { supabase } from '../lib/supabase';

export default function Confirm() {
  useEffect(() => {
    const hash = window.location.hash.substring(1);
    const params = new URLSearchParams(hash);
    const access_token = params.get('access_token');
    const refresh_token = params.get('refresh_token');
    const type = params.get('type'); // 👈 NEW: get the type param

    if (access_token && refresh_token) {
      supabase.auth
        .setSession({ access_token, refresh_token })
        .then(({ error }) => {
          if (error) {
            alert('Failed to confirm session: ' + error.message);
            window.location.href = '/signin';
          } else {
            // ✅ Branch based on type: `recovery` = password reset
            if (type === 'recovery') {
              window.location.href = '/reset';
            } else {
              window.location.href = '/dashboard';
            }
          }
        });
    } else {
      alert('No access token found.');
      window.location.href = '/signin';
    }
  }, []);

  return <p>Confirming your account...</p>;
}
