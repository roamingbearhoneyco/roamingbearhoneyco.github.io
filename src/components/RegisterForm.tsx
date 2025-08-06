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

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session) {
        window.location.href = '/dashboard';
      }
    });
  }, []);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setErrorMessage('');
    setStatus('idle');

    if (password !== confirmPassword) {
      setErrorMessage("Passwords don't match.");
      setStatus('error');
      return;
    }

    const redirectUrl = 'https://testsite.roamingbearhoneyco.com/confirm';


    console.log('📤 Attempting to sign up with:', { email, redirectUrl });

    // Check if user already exists by fetching user metadata before signing up
    const { data: existingUser, error: fetchError } = await supabase
      .from('users') // or 'auth.users' if you have access to auth users table
      .select('id')
      .eq('email', email)
      .single();

    if (!fetchError && existingUser) {
      // Redirect to signin page with message query param
      const signinUrl = `/signin?accountExists=true&email=${encodeURIComponent(email)}`;
      window.location.href = signinUrl;
      return;
    }

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: redirectUrl,
      },
    });

    if (data?.user) {
    const { id: userId } = data.user;

    const { error: profileError } = await supabase
      .from('rbhc-table-profiles')
      .insert([
        {
          user_id: userId, // assuming your profiles table uses 'user_id' as FK
          subscription_tier: 'queen', // default value
          created_at: new Date().toISOString(), // optional, if you have a created_at field
        },
      ]);

    if (profileError) {
      console.error('❌ Error creating profile:', profileError.message);
      setErrorMessage('Account created, but profile setup failed.');
      setStatus('error');
      return;
    }
  }


    // Extra check for already confirmed users based on identities length
    if (data?.user && (data.user.identities?.length ?? 0) === 0) {
      // Redirect instead of showing inline error
      const signinUrl = `/signin?accountExists=true&email=${encodeURIComponent(email)}`;
      window.location.href = signinUrl;
      return;
    }

    if (error) {
      if (error.message.toLowerCase().includes('user already registered')) {
        // Fallback redirect for existing user edge case
        const signinUrl = `/signin?accountExists=true&email=${encodeURIComponent(email)}`;
        window.location.href = signinUrl;
      } else {
        setErrorMessage(error.message);
        setStatus('error');
      }
    } else {
      setStatus('success');
      // Clear passwords after success
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

      {status === 'error' && (
        <p className="text-sm text-red-600 text-center">{errorMessage}</p>
      )}
    </form>
  );
}
