import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'

export default function SignInForm() {
  const [showReset, setShowReset] = useState(false)
  const [resetEmail, setResetEmail] = useState('')
  const [resetStatus, setResetStatus] = useState<'idle' | 'sending' | 'sent' | 'error'>('idle')
  const [errorMessage, setErrorMessage] = useState('')

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
