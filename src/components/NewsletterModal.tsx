import { useState } from 'react';
import { supabase } from '../lib/supabase';

type SubmissionState = 'idle' | 'submitting' | 'success' | 'error';

interface NewsletterModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export default function NewsletterModal({ isOpen, onClose }: NewsletterModalProps) {
  const [firstName, setFirstName] = useState('');
  const [emailAddress, setEmailAddress] = useState('');
  const [consentGiven, setConsentGiven] = useState(false);
  const [submissionState, setSubmissionState] = useState<SubmissionState>('idle');
  const [errorMessage, setErrorMessage] = useState('');

  if (!isOpen) return null;

  const isValidEmail = (value: string) => /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(value);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!consentGiven) {
      setErrorMessage('Please agree to receive marketing emails');
      return;
    }

    if (!isValidEmail(emailAddress)) {
      setErrorMessage('Please enter a valid email address');
      return;
    }

    setSubmissionState('submitting');

    try {
      const { error: profileError } = await supabase
        .from('rbhc-table-profiles')
        .insert({
          first_name: firstName,
          email: emailAddress,
        });

      if (profileError) {
        if (profileError.message.includes('ALREADY_REGISTERED')) {
          setErrorMessage("You're already in our system! Please log in to your dashboard or check your email for updates.");
        } else if (profileError.code === '23505') {
          setErrorMessage("You're already in our system! Please log in to your dashboard or check your email for updates.");
        } else {
          setErrorMessage(profileError.message);
        }
        setSubmissionState('error');
        return;
      }

      setSubmissionState('success');
      // Auto-close after 2 seconds on success
      setTimeout(() => {
        onClose();
        setFirstName('');
        setEmailAddress('');
        setConsentGiven(false);
        setSubmissionState('idle');
        setErrorMessage('');
      }, 2000);
    } catch (err) {
      setErrorMessage('Something went wrong. Please try again.');
      setSubmissionState('error');
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center px-4 py-8 bg-black/40 backdrop-blur-sm overflow-y-auto animate-in fade-in-0 duration-200">
      {/* Modal container */}
      <div className="relative w-full max-w-xl rounded-2xl border border-[rgba(215,175,121,0.15)] bg-[rgba(255,255,255,0.95)] backdrop-blur-xl shadow-2xl p-6 sm:p-8 my-8 animate-in zoom-in-95 slide-in-from-top-8 duration-300">
        {/* Close button */}
        <button
          onClick={onClose}
          className="absolute right-4 top-4 sm:right-6 sm:top-6 text-[var(--color-text-secondary)] hover:text-[#d74a4a] transition-colors duration-150 z-10"
          aria-label="Close modal"
          type="button"
        >
          <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>

        {/* Content */}
        <div className="text-center space-y-6">
          <div>
            <h2
              className="text-2xl sm:text-3xl font-bold mb-2"
              style={{
                background: 'linear-gradient(90deg, #d7af79 0%, #a05d35 100%)',
                WebkitBackgroundClip: 'text',
                WebkitTextFillColor: 'transparent',
                backgroundClip: 'text',
              }}
            >
              Join the Hive
            </h2>
            <p className="text-[var(--color-text-secondary)]/80">
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
                <label htmlFor="newsletter-modal-first-name" className="block font-semibold text-[var(--color-text-primary)] mb-2">
                  First Name
                </label>
                <input
                  id="newsletter-modal-first-name"
                  type="text"
                  value={firstName}
                  onChange={(e) => setFirstName(e.target.value)}
                  placeholder="Name"
                  className="w-full rounded-xl border border-[#e2c79e] bg-[rgba(255,255,255,0.9)] text-[#2c1c0f] px-4 py-3 shadow-sm focus:outline-none focus:ring-2 focus:ring-[#a05d35] focus:border-[#a05d35]"
                />
              </div>

              <div>
                <label htmlFor="newsletter-modal-email" className="block font-semibold text-[var(--color-text-primary)] mb-2">
                  Email<span className="ml-1 text-[#d97706]">*</span>
                </label>
                <input
                  id="newsletter-modal-email"
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
                  id="newsletter-modal-consent"
                  type="checkbox"
                  checked={consentGiven}
                  onChange={(e) => setConsentGiven(e.target.checked)}
                  className="mt-1 h-4 w-4 rounded border-[#e2c79e] text-[#a05d35] focus:ring-[#a05d35]"
                />
                <label htmlFor="newsletter-modal-consent" className="text-sm text-[var(--color-text-secondary)]">
                  I agree to receive marketing emails and updates from Roaming Bear Honey Co.
                </label>
              </div>

              {submissionState === 'error' && errorMessage && (
                <div className="rounded-xl bg-[rgba(245,231,208,0.55)] text-[#d74a4a] p-4 font-semibold text-center">
                  {errorMessage}
                </div>
              )}

              <button
                type="submit"
                disabled={submissionState === 'submitting'}
                className="w-full rounded-xl font-bold text-white py-3 shadow hover:scale-[1.02] transition-transform disabled:opacity-50 disabled:cursor-not-allowed"
                style={{ background: 'linear-gradient(90deg, #d7af79 0%, #a05d35 100%)' }}
              >
                {submissionState === 'submitting' ? 'Joining…' : 'Sign Up'}
              </button>
            </form>
          )}
        </div>
      </div>
    </div>
  );
}
