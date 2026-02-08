import { useState } from 'react';

interface SubscriptionData {
  id: number;
  profile_id: number;
  tier_id: number;
  stripe_customer_id: string | null;
  stripe_subscription_id: string | null;
  billing_cycle: number;
  status: string;
  next_renewal_date: string | null;
  created_at: string;
  subscription_tiers: {
    name: string;
    display_name: string;
  };
}

interface SubscriptionManagerProps {
  subscription: SubscriptionData;
  onPause?: () => void;
  onCancel?: () => void;
  isLoading?: boolean;
}

const formatDate = (dateStr: string | null) => {
  if (!dateStr) return 'N/A';
  return new Date(dateStr).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};

const getCycleName = (months: number) => {
  if (months === 1) return 'Monthly';
  if (months === 6) return 'Every 6 months';
  if (months === 12) return 'Annually';
  return `Every ${months} months`;
};

export default function SubscriptionManager({
  subscription,
  onPause,
  onCancel,
  isLoading = false
}: SubscriptionManagerProps) {
  const [showPauseModal, setShowPauseModal] = useState(false);
  const [showCancelModal, setShowCancelModal] = useState(false);

  const daysUntilRenewal = subscription.next_renewal_date 
    ? Math.ceil((new Date(subscription.next_renewal_date).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24))
    : null;

  return (
    <div className="space-y-6">
      <div className="card space-y-4">
        <h3 className="text-xl font-bold text-[var(--color-text-primary)]">Current Subscription</h3>
        
        <div className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <p className="text-[var(--color-text-secondary)] text-xs uppercase">Tier</p>
            <p className="text-lg font-semibold text-[var(--color-primary)]">
              {subscription.subscription_tiers.display_name}
            </p>
          </div>
          
          <div>
            <p className="text-[var(--color-text-secondary)] text-xs uppercase">Billing Cycle</p>
            <p className="text-lg font-semibold">{getCycleName(subscription.billing_cycle)}</p>
          </div>
          
          <div>
            <p className="text-[var(--color-text-secondary)] text-xs uppercase">Status</p>
            <p className={`text-lg font-semibold capitalize ${
              subscription.status === 'active' ? 'text-green-600' : 'text-orange-600'
            }`}>
              {subscription.status}
            </p>
          </div>
          
          <div>
            <p className="text-[var(--color-text-secondary)] text-xs uppercase">Next Renewal</p>
            <p className="text-lg font-semibold">
              {formatDate(subscription.next_renewal_date)}
            </p>
            {daysUntilRenewal !== null && daysUntilRenewal > 0 && (
              <p className="text-xs text-[var(--color-text-secondary)]">
                ({daysUntilRenewal} days away)
              </p>
            )}
          </div>
        </div>
      </div>

      {subscription.subscription_tiers.name !== 'free' && (
        <div className="card space-y-4">
          <h3 className="font-bold text-[var(--color-text-primary)]">Manage Subscription</h3>
          
          <div className="space-y-3">
            {onPause && (
              <button
                onClick={() => setShowPauseModal(true)}
                disabled={isLoading}
                className="w-full px-4 py-2 border border-[var(--color-accent)] rounded-lg hover:bg-[var(--color-accent)]/10 transition-colors disabled:opacity-50"
              >
                Pause Subscription
              </button>
            )}
            
            {onCancel && (
              <button
                onClick={() => setShowCancelModal(true)}
                disabled={isLoading}
                className="w-full px-4 py-2 border border-red-500 text-red-600 rounded-lg hover:bg-red-50 transition-colors disabled:opacity-50"
              >
                Cancel Subscription
              </button>
            )}
          </div>
        </div>
      )}

      {showPauseModal && onPause && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg p-6 max-w-md w-full space-y-4">
            <h3 className="text-xl font-bold">Pause Subscription?</h3>
            <p className="text-[var(--color-text-secondary)]">
              You can pause your subscription for up to 3 months.
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => setShowPauseModal(false)}
                className="flex-1 px-4 py-2 border rounded-lg hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={() => {
                  onPause();
                  setShowPauseModal(false);
                }}
                disabled={isLoading}
                className="flex-1 px-4 py-2 bg-[var(--color-secondary)] text-white rounded-lg hover:bg-[var(--color-accent)] disabled:opacity-50"
              >
                {isLoading ? 'Processing...' : 'Pause'}
              </button>
            </div>
          </div>
        </div>
      )}

      {showCancelModal && onCancel && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg p-6 max-w-md w-full space-y-4">
            <h3 className="text-xl font-bold text-red-600">Cancel Subscription?</h3>
            <p className="text-[var(--color-text-secondary)]">
              Your subscription will end at the end of your billing period.
            </p>
            <div className="flex gap-3">
              <button
                onClick={() => setShowCancelModal(false)}
                className="flex-1 px-4 py-2 border rounded-lg hover:bg-gray-50"
              >
                Keep It
              </button>
              <button
                onClick={() => {
                  onCancel();
                  setShowCancelModal(false);
                }}
                disabled={isLoading}
                className="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 disabled:opacity-50"
              >
                {isLoading ? 'Processing...' : 'Cancel'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}