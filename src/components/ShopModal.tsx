import { useState } from 'react';
import TierSelector from './TierSelector';

interface ShopModalProps {
  isOpen: boolean;
  onClose: () => void;
}

export default function ShopModal({ isOpen, onClose }: ShopModalProps) {
  if (!isOpen) return null;

  const handleUpgrade = (tierId: number, billingCycle: number) => {
    // When user selects a tier, we might want to do something here
    // For now, just log it - in a real app, this would trigger checkout
    console.log(`Selected tier ${tierId} with billing cycle ${billingCycle}`);
    // Optionally close after selection - depends on your UX preference
    // onClose();
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center px-4 py-8 bg-black/40 backdrop-blur-sm overflow-y-auto animate-in fade-in-0 duration-200">
      {/* Modal container - responsive sizing */}
      <div className="relative w-full max-w-4xl rounded-2xl border border-[rgba(215,175,121,0.15)] bg-[rgba(255,255,255,0.95)] backdrop-blur-xl shadow-2xl p-6 sm:p-8 my-8 animate-in zoom-in-95 slide-in-from-top-8 duration-300">
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
        <div className="space-y-6">
          <div className="text-center">
            <h2
              className="text-2xl sm:text-3xl font-bold mb-2"
              style={{
                background: 'linear-gradient(90deg, #d7af79 0%, #a05d35 100%)',
                WebkitBackgroundClip: 'text',
                WebkitTextFillColor: 'transparent',
                backgroundClip: 'text',
              }}
            >
              Browse Our Shop
            </h2>
            <p className="text-[var(--color-text-secondary)]/80">
              Choose your perfect honey subscription tier
            </p>
          </div>

          {/* TierSelector component */}
          <div className="overflow-auto max-h-[calc(100vh-200px)] sm:max-h-none">
            <TierSelector onUpgrade={handleUpgrade} />
          </div>
        </div>
      </div>
    </div>
  );
}
