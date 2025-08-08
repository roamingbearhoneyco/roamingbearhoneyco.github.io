import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { Eye, EyeOff } from 'lucide-react' // Optional: or use SVGs

export default function ResetPassword() {
  const [newPassword, setNewPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [status, setStatus] = useState<'checking' | 'waiting' | 'success' | 'error' | 'unauthorized'>('checking')
  const [errorMessage, setErrorMessage] = useState('')

  useEffect(() => {
    const hash = window.location.hash.substring(1)
    const params = new URLSearchParams(hash)
    const access_token = params.get('access_token')
    const refresh_token = params.get('refresh_token')

    if (access_token && refresh_token) {
      supabase.auth.setSession({ access_token, refresh_token }).then(({ error }) => {
        if (error) {
          setStatus('unauthorized')
        } else {
          setStatus('waiting')
        }
      })
    } else {
      supabase.auth.getUser().then(({ data, error }) => {
        if (error || !data?.user) {
          setStatus('unauthorized')
        } else {
          setStatus('waiting')
        }
      })
    }
  }, [])

  const handlePasswordReset = async () => {
    if (newPassword !== confirmPassword) {
      setErrorMessage("Passwords don't match.")
      setStatus('error')
      return
    }

    const { error } = await supabase.auth.updateUser({ password: newPassword })
    if (error) {
      setErrorMessage(error.message)
      setStatus('error')
    } else {
      setStatus('success')
      setTimeout(() => {
        window.location.href = '/portal'
      }, 2000)
    }
  }

  if (status === 'checking') {
    return (
      <div className="text-center text-sm text-gray-600">
        <p>Checking session...</p>
      </div>
    )
  }

  if (status === 'unauthorized') {
    return (
      <div className="text-center text-sm text-red-600 max-w-md mx-auto">
        <p>You must follow the password reset link from your email.</p>
      </div>
    )
  }

  return (
    <div className="max-w-md mx-auto bg-white border border-gray-200 shadow-md rounded p-6 space-y-4 text-center">
      <h2 className="text-xl font-bold text-[#19360e]">Reset your password</h2>
      {status === 'success' ? (
        <p className="text-green-600 font-medium">Password reset! Redirecting...</p>
      ) : (
        <div className="space-y-4 text-left">
          <div className="relative">
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="New password"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
            />
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              className="absolute inset-y-0 right-2 flex items-center text-gray-500"
              tabIndex={-1}
            >
              {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
            </button>
          </div>

          <div className="relative">
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="Confirm password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded shadow-sm focus:outline-none focus:ring-[#a05d35] focus:border-[#a05d35]"
            />
          </div>

          <button
            onClick={handlePasswordReset}
            className="w-full bg-[#a05d35] text-white py-2 px-4 rounded hover:bg-[#8c4c29] transition-colors font-semibold"
          >
            Update Password
          </button>

          {status === 'error' && (
            <p className="text-sm text-red-600">{errorMessage}</p>
          )}
        </div>
      )}
    </div>
  )
}
