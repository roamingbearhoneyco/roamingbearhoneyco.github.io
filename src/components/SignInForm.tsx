import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'

export default function SignInForm() {
  const [showReset, setShowReset] = useState(false)
  const [resetEmail, setResetEmail] = useState('')
  const [resetStatus, setResetStatus] = useState<'idle' | 'sending' | 'sent' | 'error'>('idle')
  const [errorMessage, setErrorMessage] = useState('')
  const [isGoogleLoading, setIsGoogleLoading] = useState(false)

  const [accountExists, setAccountExists] = useState(false)
  const [emailFromQuery, setEmailFromQuery] = useState('')

  useEffect(() => {
    // Read URL params manually
    const params = new URLSearchParams(window.location.search)
    if (params.get('accountExists') === 'true') {
      setAccountExists(true)
    }
    const email = params.get('email')
    if (email) {
      setEmailFromQuery(email)
      setResetEmail(email) // optionally prefill the reset email field
    }

    // Check if user session exists and redirect if so
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session) {
        window.location.href = '/portal'
      }
    })
  }, [])

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    const form = e.currentTarget
    const email = (form.elements.namedItem('email') as HTMLInputElement).value
    const password = (form.elements.namedItem('password') as HTMLInputElement).value

    const { error } = await supabase.auth.signInWithPassword({ email, password })
    if (error) {
      alert(error.message)
    } else {
      window.location.href = '/portal'
    }
  }

  const handlePasswordReset = async () => {
    setResetStatus('sending')
    const { error } = await supabase.auth.resetPasswordForEmail(resetEmail, {
      redirectTo: `${window.location.origin}/reset`,
    })
    if (error) {
      setResetStatus('error')
      setErrorMessage(error.message)
    } else {
      setResetStatus('sent')
    }
  }

  return (
    <div className="space-y-6 bg-white p-6 rounded shadow-md border border-gray-200 max-w-md mx-auto">
      {accountExists && (
        <div className="mb-4 p-3 bg-yellow-100 text-yellow-800 rounded border border-yellow-300">
          An account with {emailFromQuery ? `"${emailFromQuery}" ` : ''}already exists. Please sign in instead.
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label htmlFor="email" className="block text-sm font-medium text-gray-700">
            Email
          </label>
          <input
            type="email"
            name="email"
            id="email"
            required
            defaultValue={emailFromQuery}
            className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
          />
        </div>

        <div>
          <label htmlFor="password" className="block text-sm font-medium text-gray-700">
            Password
          </label>
          <input
            type="password"
            name="password"
            id="password"
            required
            className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
          />
        </div>

        <button
          type="submit"
          className="w-full bg-[#a05d35] text-white py-2 px-4 rounded hover:bg-[#8c4c29] transition-colors font-semibold"
        >
          Login
        </button>
      </form>

      <div className="flex items-center gap-3">
        <div className="flex-1 h-px bg-gray-200" />
        <span className="text-xs uppercase tracking-wide text-gray-500">or</span>
        <div className="flex-1 h-px bg-gray-200" />
      </div>

      <button
        type="button"
        onClick={async () => {
          try {
            setIsGoogleLoading(true)
            const { error } = await supabase.auth.signInWithOAuth({
              provider: 'google',
              options: {
                redirectTo: `${window.location.origin}/portal`,
                queryParams: {
                  access_type: 'offline',
                  prompt: 'consent',
                },
              },
            })
            if (error) {
              setErrorMessage(error.message)
            }
          } catch (err) {
            setErrorMessage('Unable to start Google sign-in.')
          } finally {
            setIsGoogleLoading(false)
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

      <div className="text-sm text-center">
        <button
          onClick={() => setShowReset(!showReset)}
          className="text-[#a05d35] hover:underline font-medium"
        >
          Forgot your password?
        </button>
      </div>

      {showReset && (
        <div className="space-y-2 pt-4 border-t border-gray-200">
          <input
            type="email"
            placeholder="Enter your email"
            value={resetEmail}
            onChange={(e) => setResetEmail(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
          />
          <button
            onClick={handlePasswordReset}
            className="w-full bg-gray-100 text-[#a05d35] py-2 px-4 rounded border hover:bg-gray-200 transition-colors font-semibold"
          >
            Send Reset Link
          </button>

          {resetStatus === 'sent' && (
            <p className="text-sm text-green-600">Reset link sent! Check your email.</p>
          )}
          {resetStatus === 'error' && (
            <p className="text-sm text-red-600">Error: {errorMessage}</p>
          )}
        </div>
      )}
    </div>
  )
}
