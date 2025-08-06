// src/components/ResetPassword.tsx
import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';

export default function ResetPassword() {
  const [newPassword, setNewPassword] = useState('');
  const [status, setStatus] = useState<'checking' | 'waiting' | 'success' | 'error' | 'unauthorized'>('checking');
  const [errorMessage, setErrorMessage] = useState('');

  // Parse tokens from URL and set session
  useEffect(() => {
    const hash = window.location.hash.substring(1);
    const params = new URLSearchParams(hash);
    const access_token = params.get('access_token');
    const refresh_token = params.get('refresh_token');

    if (access_token && refresh_token) {
      supabase.auth.setSession({ access_token, refresh_token }).then(({ error }) => {
        if (error) {
          setStatus('unauthorized');
        } else {
          setStatus('waiting');
        }
      });
    } else {
      // Check session in case it's already active
      supabase.auth.getUser().then(({ data, error }) => {
        if (error || !data?.user) {
          setStatus('unauthorized');
        } else {
          setStatus('waiting');
        }
      });
    }
  }, []);

  const handlePasswordReset = async () => {
    const { error } = await supabase.auth.updateUser({ password: newPassword });
    if (error) {
      setErrorMessage(error.message);
      setStatus('error');
    } else {
      setStatus('success');
      setTimeout(() => {
        window.location.href = '/dashboard';
      }, 2000);
    }
  };

  if (status === 'checking') return <p>Checking session...</p>;
  if (status === 'unauthorized') return <p>You must follow the password reset link from your email.</p>;

  return (
    <div>
      <h2>Reset your password</h2>
      {status === 'success' ? (
        <p>Password reset! Redirecting...</p>
      ) : (
        <>
          <input
            type="password"
            placeholder="New password"
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
          />
          <button onClick={handlePasswordReset}>Update Password</button>
          {status === 'error' && <p style={{ color: 'red' }}>{errorMessage}</p>}
        </>
      )}
    </div>
  );
}
