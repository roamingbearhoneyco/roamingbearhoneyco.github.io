// src/components/Confirm.tsx
import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';

export default function Confirm() {
  const [status, setStatus] = useState<'loading' | 'error' | 'success'>('loading');
  const [message, setMessage] = useState('Confirming your account...');

  useEffect(() => {
    const hash = window.location.hash.substring(1);
    const params = new URLSearchParams(hash);
    const access_token = params.get('access_token');
    const refresh_token = params.get('refresh_token');
    const type = params.get('type');

    if (access_token && refresh_token) {
      supabase.auth
        .setSession({ access_token, refresh_token })
        .then(({ error }) => {
          if (error) {
            setStatus('error');
            setMessage('Something went wrong while confirming. Redirecting...');
            setTimeout(() => (window.location.href = '/signin'), 2000);
          } else {
            setStatus('success');
            setMessage(type === 'recovery' ? 'Password reset confirmed. Redirecting...' : 'Account confirmed! Redirecting...');
            setTimeout(() => {
              window.location.href = type === 'recovery' ? '/reset' : '/portal';
            }, 1500);
          }
        });
    } else {
      setStatus('error');
      setMessage('Missing access credentials. Redirecting...');
      setTimeout(() => (window.location.href = '/signin'), 1500);
    }
  }, []);

  return (
    <div className="card max-w-md mx-auto text-center space-y-4">
      <h1 className="text-xl font-bold text-[var(--color-primary)]">Hold tight!</h1>
      <p className={`text-sm ${status === 'error' ? 'text-red-600' : 'text-[var(--color-text-secondary)]'}`}>
        {message}
      </p>
    </div>
  );
}
