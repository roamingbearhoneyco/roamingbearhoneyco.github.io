import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'

type SubmissionState = 'idle' | 'submitting' | 'success' | 'error'

export default function EmailCaptureModal() {
  const [isOpen, setIsOpen] = useState(true)
  const [firstName, setFirstName] = useState('')
  const [emailAddress, setEmailAddress] = useState('')
  const [consentGiven, setConsentGiven] = useState(false)
  const [submissionState, setSubmissionState] = useState<SubmissionState>('idle')
  const [errorMessage, setErrorMessage] = useState('')

  useEffect(() => {
    // Auto-focus first field when opened
    if (isOpen) {
      const input = document.getElementById('newsletter-first-name-input') as HTMLInputElement | null
      input?.focus()
    }
  }, [isOpen])

  const isValidEmail = (value: string) => /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(value)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    // Consent must be given
    if (!consentGiven) {
      setErrorMessage('Please confirm you agree to receive marketing emails.')
      setSubmissionState('error')
      return
    }
    if (!isValidEmail(emailAddress)) {
      setErrorMessage('Please enter a valid email address.')
      setSubmissionState('error')
      return
    }
    setSubmissionState('submitting')
    setErrorMessage('')

    try {
      const { error } = await supabase
        .from('rbhc-table-profiles')
        // Intentionally not setting user_id (NULL for email-only lead)
        .insert({
          first_name: firstName,
          email: emailAddress,
          subscription_tier: 'free',
        })

      if (error) {
        setErrorMessage(error.message)
        setSubmissionState('error')
      } else {
        setSubmissionState('success')
      }
    } catch (err) {
      setErrorMessage('Something went wrong. Please try again.')
      setSubmissionState('error')
    }
  }

  if (!isOpen) return null

  return (
    <div className="relative z-20 flex items-center justify-center min-h-screen px-4">
      {/* Card */}
      <div className="w-full max-w-xl rounded-2xl border border-[rgba(215,175,121,0.15)] bg-[rgba(255,255,255,0.45)] backdrop-blur-xl shadow-[0_8px_32px_rgba(44,28,15,0.12),_0_2px_12px_rgba(160,93,53,0.08)] p-6 sm:p-8">
        <button
          type="button"
          aria-label="Close"
          className="absolute right-3 top-3 text-[#a05d35] hover:text-[#8c4c29]"
          onClick={() => setIsOpen(false)}
        >
          ✕
        </button>

        <div className="text-center mb-4">
          <h2
            className="text-2xl sm:text-3xl font-bold mb-1"
            style={{
              background: 'linear-gradient(90deg, #d7af79 0%, #a05d35 100%)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              backgroundClip: 'text',
            }}
          >
            Join the Hive
          </h2>
          <p className="text-[var(--color-text-secondary,#2c1c0f)]/80">
            Subscribe for new products, harvest updates, and RBHC news.
          </p>
        </div>

        {submissionState === 'success' ? (
          <div className="rounded-xl bg-[rgba(245,231,208,0.55)] text-[#388e3c] p-4 font-semibold text-center">
            Thank you for joining! 🐻🍯
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label htmlFor="newsletter-first-name-input" className="block font-semibold text-white mb-1">
                First Name
              </label>
              <input
                id="newsletter-first-name-input"
                type="text"
                value={firstName}
                onChange={(e) => setFirstName(e.target.value)}
                placeholder="Name"
                className="w-full rounded-xl border border-[#e2c79e] bg-[rgba(255,255,255,0.9)] text-[#2c1c0f] px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-[#a05d35] focus:border-[#a05d35]"
              />
            </div>

            <div>
              <label htmlFor="newsletter-email-input" className="block font-semibold text-white mb-1">
                Email<span className="ml-1 text-[#d97706]">*</span>
              </label>
              <input
                id="newsletter-email-input"
                type="email"
                value={emailAddress}
                onChange={(e) => setEmailAddress(e.target.value)}
                placeholder="someone@example.com"
                className="w-full rounded-xl border border-[#e2c79e] bg-[rgba(255,255,255,0.9)] text-[#2c1c0f] px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-[#a05d35] focus:border-[#a05d35]"
                required
              />
            </div>

            <div className="flex items-start gap-3">
              <input
                id="newsletter-consent"
                type="checkbox"
                checked={consentGiven}
                onChange={(e) => setConsentGiven(e.target.checked)}
                className="mt-1 h-4 w-4 rounded border-[#e2c79e] text-[#a05d35] focus:ring-[#a05d35]"
              />
              <label htmlFor="newsletter-consent" className="text-white">
                I agree to receive marketing emails and updates from Roaming Bear Honey Co.
              </label>
            </div>

            {submissionState === 'error' && errorMessage && (
              <p className="-mt-2 text-[#d97706] text-sm">{errorMessage}</p>
            )}

            <button
              type="submit"
              disabled={submissionState === 'submitting'}
              className="w-full rounded-xl font-bold text-white py-3 shadow hover:scale-[1.02] transition-transform"
              style={{ background: 'linear-gradient(90deg, #d7af79 0%, #a05d35 100%)' }}
            >
              {submissionState === 'submitting' ? 'Joining…' : 'Sign Up'}
            </button>
          </form>
        )}
      </div>
    </div>
  )
}


