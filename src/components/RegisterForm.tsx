import { useEffect, useState } from 'react';
import { supabase } from '../lib/supabase';
import { Eye, EyeOff } from 'lucide-react';

export default function RegisterForm() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [status, setStatus] = useState<'idle' | 'error' | 'success'>('idle');
  const [errorMessage, setErrorMessage] = useState('');
  const [isGoogleLoading, setIsGoogleLoading] = useState(false);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session) {
        window.location.href = '/portal';
      }
    });
  }, []);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => { 
    e.preventDefault();
    setErrorMessage('');
    setStatus('idle');

    // ✅ Check password match
    if (password !== confirmPassword) {
      setErrorMessage("Passwords don't match.");
      setStatus('error');
      return;
    }

    const redirectUrl = 'https://testsite.roamingbearhoneyco.com/confirm';

    console.log('📤 Attempting to sign up with:', { email, redirectUrl });

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: redirectUrl,
      },
    });

    // ❌ Handle signup errors
    if (error) {
      if (error.message.toLowerCase().includes('user already registered')) {
        window.location.href = `/signin?accountExists=true&email=${encodeURIComponent(email)}`;
      } else {
        setErrorMessage(error.message);
        setStatus('error');
      }
      return;
    }

    const user = data?.user;

    if (user) {
      const { identities } = user;

      // If no identities, it's likely an existing account
      if ((identities?.length ?? 0) === 0) {
        window.location.href = `/signin?accountExists=true&email=${encodeURIComponent(email)}`;
        return;
      }

      // ✅ Profile is created automatically by trigger — just mark success
      setStatus('success');
      setPassword('');
      setConfirmPassword('');
    }
  };

  if (status === 'success') {
    return (
      <div className="max-w-md mx-auto bg-white p-6 rounded shadow-md border border-gray-200 text-center">
        <h2 className="text-lg font-semibold mb-4 text-green-600">
          Success! Your account has been created.
        </h2>
        <p>Please check your email for a confirmation link to activate your account.</p>
      </div>
    );
  }

  return (
    <form
      onSubmit={handleSubmit}
      className="space-y-6 bg-white p-6 rounded shadow-md border border-gray-200 max-w-md mx-auto"
    >
      <div>
        <label htmlFor="email" className="block text-sm font-medium text-gray-700">
          Email
        </label>
        <input
          type="email"
          id="email"
          name="email"
          required
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
          autoFocus
        />
      </div>

      <div className="relative">
        <label htmlFor="password" className="block text-sm font-medium text-gray-700">
          Password
        </label>
        <input
          type={showPassword ? 'text' : 'password'}
          id="password"
          name="password"
          required
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="mt-1 block w-full px-3 py-2 pr-10 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
        />
        <button
          type="button"
          onClick={() => setShowPassword(!showPassword)}
          className="absolute right-3 top-[38px] text-gray-500"
          tabIndex={-1}
          aria-label={showPassword ? 'Hide password' : 'Show password'}
        >
          {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
        </button>
      </div>

      <div className="relative">
        <label htmlFor="confirmPassword" className="block text-sm font-medium text-gray-700">
          Confirm Password
        </label>
        <input
          type={showPassword ? 'text' : 'password'}
          id="confirmPassword"
          name="confirmPassword"
          required
          value={confirmPassword}
          onChange={(e) => setConfirmPassword(e.target.value)}
          className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
        />
      </div>

      <button
        type="submit"
        className="w-full bg-[#a05d35] text-white py-2 px-4 rounded hover:bg-[#8c4c29] transition-colors font-semibold"
      >
        Register
      </button>

      <div className="flex items-center gap-3">
        <div className="flex-1 h-px bg-gray-200" />
        <span className="text-xs uppercase tracking-wide text-gray-500">or</span>
        <div className="flex-1 h-px bg-gray-200" />
      </div>

      <button
        type="button"
        onClick={async () => {
          try {
            setIsGoogleLoading(true);
            const { error } = await supabase.auth.signInWithOAuth({
              provider: 'google',
              options: {
                redirectTo: `${window.location.origin}/portal`,
                queryParams: {
                  // request refresh token from Google
                  access_type: 'offline',
                  prompt: 'select_account',
                },
              },
            });
            if (error) {
              setErrorMessage(error.message);
              setStatus('error');
            }
          } catch (err) {
            setErrorMessage('Unable to start Google sign-in.');
            setStatus('error');
          } finally {
            setIsGoogleLoading(false);
          }
        }}
        className="w-full bg-white text-[#2C1C0F] py-2 px-4 rounded border border-[rgba(215,175,121,0.7)] hover:bg-[#f5e7d0] transition-colors font-semibold shadow-sm flex items-center justify-center gap-2"
        aria-label="Continue with Google"
        disabled={isGoogleLoading}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="18"
          height="18"
          viewBox="0 0 48 48"
          aria-hidden="true"
        >
          <path fill="#FFC107" d="M43.611 20.083H42V20H24v8h11.303c-1.649 4.657-6.08 8-11.303 8-6.627 0-12-5.373-12-12s5.373-12 12-12c3.059 0 5.842 1.153 7.961 3.039l5.657-5.657C34.046 6.053 29.268 4 24 4 12.954 4 4 12.954 4 24s8.954 20 20 20 20-8.954 20-20c0-1.341-.138-2.651-.389-3.917z"/>
          <path fill="#FF3D00" d="M6.306 14.691l6.571 4.819C14.4 16.108 18.834 12 24 12c3.059 0 5.842 1.153 7.961 3.039l5.657-5.657C34.046 6.053 29.268 4 24 4 16.318 4 9.656 8.337 6.306 14.691z"/>
          <path fill="#4CAF50" d="M24 44c5.166 0 9.86-1.977 13.409-5.197l-6.191-5.238C29.104 35.977 26.689 37 24 37c-5.202 0-9.62-3.317-11.283-7.953l-6.49 5.005C9.518 39.556 16.227 44 24 44z"/>
          <path fill="#1976D2" d="M43.611 20.083H42V20H24v8h11.303a12.02 12.02 0 01-4.095 5.562l.003-.002 6.191 5.238C36.882 40.205 44 36 44 24c0-1.341-.138-2.651-.389-3.917z"/>
        </svg>
        {isGoogleLoading ? 'Connecting…' : 'Continue with Google'}
      </button>

      {status === 'error' && (
        <p className="text-sm text-red-600 text-center">{errorMessage}</p>
      )}
    </form>
  );
}
