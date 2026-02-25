import { useState, useEffect } from 'react';
import { supabase } from '../lib/supabase';

interface Tier {
  id: number;
  name: string;
  display_name: string;
  description: string;
  price_monthly: number;
  price_6month: number;
  price_yearly: number;
  benefits: {
    honey_jars_per_year: number;
    discount_percent: number;
    merchandise: string[];
  };
}

interface TierSelectorProps {
  currentTierName?: string;
  onUpgrade?: (tierId: number, billingCycle: number) => void;
  isLoading?: boolean;
}

export default function TierSelector({ currentTierName, onUpgrade, isLoading: externalLoading = false }: TierSelectorProps) {
  const [tiers, setTiers] = useState<Tier[]>([]);
  const [selectedCycle, setSelectedCycle] = useState(1);
  const [loading, setLoading] = useState(true);
  const [checkoutLoading, setCheckoutLoading] = useState<number | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchTiers = async () => {
      try {
        const { data: result, error } = await supabase
          .from('subscription_tiers')
          .select('*')
          .order('id');
        
        if (!error && result) {
          setTiers(result);
        }
      } catch (err) {
        console.error('Failed to fetch tiers:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchTiers();
  }, []);

  const getPrice = (tier: Tier, cycle: number) => {
    const priceInCents = cycle === 1 ? tier.price_monthly : cycle === 6 ? tier.price_6month : tier.price_yearly;
    return (priceInCents / 100).toFixed(2);
  };

  const handleUpgradeClick = async (tierId: number, billingCycle: number) => {
    // If custom callback provided, use it
    if (onUpgrade) {
      onUpgrade(tierId, billingCycle);
      return;
    }

    // Otherwise, use built-in Stripe checkout
    setCheckoutLoading(tierId);
    setError(null);

    try {
      const { data: { session }, error: sessionError } = await supabase.auth.getSession();
      
      if (sessionError || !session?.access_token) {
        setError('Please sign in to upgrade your plan');
        setCheckoutLoading(null);
        return;
      }

      // Call checkout endpoint
      const response = await fetch('/api/checkout', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${session.access_token}`,
        },
        body: JSON.stringify({
          tier_id: tierId,
          billing_cycle: billingCycle,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || 'Failed to start checkout');
        setCheckoutLoading(null);
        return;
      }

      // Redirect to Stripe checkout
      if (data.sessionUrl) {
        window.location.href = data.sessionUrl;
      }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'An error occurred';
      setError(message);
      setCheckoutLoading(null);
    }
  };

  const getMiddleTierIndex = Math.floor(tiers.length / 2);
  const isMiddleTier = (index: number) => index === getMiddleTierIndex && tiers.length > 0;

  if (loading) {
    return <div className="text-center py-12">Loading tiers...</div>;
  }

  return (
    <div className="space-y-8">
      {/* Error Message */}
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg max-w-4xl mx-auto">
          {error}
        </div>
      )}

      {/* Billing Cycle Selector */}
      <div className="flex justify-center gap-3 flex-wrap">
        {[
          { value: 1, label: 'Monthly' },
          { value: 6, label: '6 Months', discount: '15% off' },
          { value: 12, label: 'Yearly', discount: '20% off' }
        ].map(option => (
          <button
            key={option.value}
            onClick={() => setSelectedCycle(option.value)}
            className={`px-6 py-3 rounded-lg font-semibold transition-all ${
              selectedCycle === option.value
                ? 'bg-[var(--color-secondary)] text-white shadow-lg'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            {option.label}
            {option.discount && <span className="text-xs ml-2 opacity-90">({option.discount})</span>}
          </button>
        ))}
      </div>

      {/* Tier Cards Grid - Responsive Grid Layout */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6 lg:gap-8 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 transition-all">
        {tiers.map((tier, index) => {
          const isMiddle = isMiddleTier(index);
          const isCurrent = tier.name === currentTierName;

          return (
            <div
              key={tier.id}
              className={`relative flex flex-col rounded-2xl overflow-hidden transition-all transform hover:scale-105 h-full ${
                isMiddle
                  ? 'ring-2 ring-offset-2 ring-[var(--color-secondary)] shadow-2xl'
                  : 'shadow-lg hover:shadow-xl'
              } ${
                isCurrent
                  ? 'ring-2 ring-offset-2 ring-[var(--color-accent)]'
                  : ''
              }`}
            >
              {/* Card Background */}
              <div className={`absolute inset-0 bg-white`} />

              {/* Recommended Badge - Only on Middle Tier */}
              {isMiddle && (
                <div className="absolute top-0 left-0 right-0 bg-gradient-to-r from-[var(--color-secondary)] to-[var(--color-accent)] text-white py-2 text-center font-bold text-sm z-10">
                  🐻 Recommended
                </div>
              )}

              {/* Current Plan Badge */}
              {isCurrent && (
                <div className="absolute top-2 right-2 bg-[var(--color-accent)] text-white text-xs font-bold px-3 py-1 rounded-full z-10">
                  Current
                </div>
              )}

              {/* Content */}
              <div className="relative z-0 p-6 space-y-4 flex flex-col h-full">
                {/* Spacing for badge if middle tier */}
                {isMiddle && <div className="h-8" />}

                {/* Title */}
                <h3 className="text-xl font-bold text-[var(--color-text-primary)]">
                  {tier.display_name}
                </h3>

                {/* Description */}
                <p className="text-sm text-[var(--color-text-secondary)] line-clamp-3">
                  {tier.description}
                </p>

                {/* Price */}
                <div className={`text-3xl font-bold ${
                  isMiddle
                    ? 'text-[var(--color-secondary)]'
                    : 'text-[var(--color-text-primary)]'
                }`}>
                  ${getPrice(tier, selectedCycle)}
                  <span className="text-sm text-gray-500 font-normal ml-1">
                    /{selectedCycle === 1 ? 'mo' : selectedCycle === 6 ? '6 mo' : 'year'}
                  </span>
                </div>

                {/* Benefits */}
                <ul className="space-y-2 text-base text-[var(--color-text-secondary)] flex-grow">
                  {tier.benefits.honey_jars_per_year > 0 && (
                    <li className="flex items-start">
                      <span className="text-[var(--color-secondary)] mr-2 font-bold flex-shrink-0">✓</span>
                      <span>{tier.benefits.honey_jars_per_year} jar{tier.benefits.honey_jars_per_year > 1 ? 's' : ''} of honey/year</span>
                    </li>
                  )}
                  {tier.benefits.merchandise && tier.benefits.merchandise.length > 0 && (
                    <li className="flex items-start">
                      <span className="text-[var(--color-secondary)] mr-2 font-bold flex-shrink-0">✓</span>
                      <span>Exclusive merch & swag</span>
                    </li>
                  )}
                  {tier.benefits.discount_percent > 0 && (
                    <li className="flex items-start">
                      <span className="text-[var(--color-secondary)] mr-2 font-bold flex-shrink-0">✓</span>
                      <span>{tier.benefits.discount_percent}% member discount</span>
                    </li>
                  )}
                </ul>

                {/* Button */}
                <button
                  onClick={() => handleUpgradeClick(tier.id, selectedCycle)}
                  disabled={externalLoading || checkoutLoading !== null || tier.name === 'free' || isCurrent}
                  className={`w-full py-3 rounded-lg font-bold transition-all transform active:scale-95 flex items-center justify-center gap-2 ${
                    tier.name === 'free'
                      ? 'bg-gray-300 text-gray-500 cursor-not-allowed'
                      : isCurrent
                      ? 'bg-gray-300 text-gray-700 cursor-not-allowed'
                      : checkoutLoading === tier.id
                      ? 'bg-opacity-70 cursor-wait'
                      : isMiddle
                      ? 'bg-gradient-to-r from-[var(--color-secondary)] to-[var(--color-accent)] text-white hover:shadow-lg'
                      : 'btn btn-secondary hover:scale-105'
                  }`}
                >
                  {checkoutLoading === tier.id && (
                    <span className="animate-spin rounded-full h-4 w-4 border-2 border-white/30 border-t-white"></span>
                  )}
                  {tier.name === 'free' ? 'Free Plan' : isCurrent ? 'Current Plan' : 'Select Plan'}
                </button>
              </div>
            </div>
          );
        })}
      </div>

      {/* Info Text */}
      <div className="text-center text-sm text-[var(--color-text-secondary)]">
        <p>All plans include priority member support and access to exclusive content.</p>
      </div>
    </div>
  );
}