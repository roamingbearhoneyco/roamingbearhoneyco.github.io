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
  onUpgrade: (tierId: number, billingCycle: number) => void;
  isLoading?: boolean;
}

export default function TierSelector({ currentTierName, onUpgrade, isLoading = false }: TierSelectorProps) {
  const [tiers, setTiers] = useState<Tier[]>([]);
  const [selectedCycle, setSelectedCycle] = useState(1);
  const [loading, setLoading] = useState(true);

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

  if (loading) {
    return <div className="text-center py-8">Loading tiers...</div>;
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-center gap-4 mb-8 flex-wrap">
        {[
          { value: 1, label: 'Monthly' },
          { value: 6, label: '6 Months', discount: '15% off' },
          { value: 12, label: 'Yearly', discount: '20% off' }
        ].map(option => (
          <button
            key={option.value}
            onClick={() => setSelectedCycle(option.value)}
            className={`px-4 py-2 rounded-lg font-semibold transition-all ${
              selectedCycle === option.value
                ? 'bg-[var(--color-secondary)] text-white'
                : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
            }`}
          >
            {option.label}
            {option.discount && <span className="text-xs ml-1">({option.discount})</span>}
          </button>
        ))}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {tiers.map(tier => (
          <div
            key={tier.id}
            className={`card flex flex-col space-y-4 ${
              tier.name === currentTierName ? 'ring-2 ring-[var(--color-secondary)]' : ''
            }`}
          >
            {tier.name === currentTierName && (
              <div className="bg-[var(--color-accent)] text-white text-xs font-bold px-3 py-1 rounded text-center">
                Current Plan
              </div>
            )}

            <h3 className="text-lg font-bold text-[var(--color-text-primary)]">{tier.display_name}</h3>
            <p className="text-sm text-[var(--color-text-secondary)]">{tier.description}</p>

            <div className="text-2xl font-bold text-[var(--color-secondary)]">
              ${getPrice(tier, selectedCycle)}
              <span className="text-sm text-gray-500">/{selectedCycle === 1 ? 'mo' : selectedCycle === 6 ? '6 mo' : 'year'}</span>
            </div>

            <ul className="space-y-2 text-sm text-[var(--color-text-secondary)]">
              {tier.benefits.honey_jars_per_year > 0 && (
                <li>✓ {tier.benefits.honey_jars_per_year} jar{tier.benefits.honey_jars_per_year > 1 ? 's' : ''} of honey/year</li>
              )}
              {tier.benefits.merchandise && tier.benefits.merchandise.length > 0 && (
                <li>✓ Exclusive merch</li>
              )}
              {tier.benefits.discount_percent > 0 && (
                <li>✓ {tier.benefits.discount_percent}% discount</li>
              )}
            </ul>

            <button
              onClick={() => onUpgrade(tier.id, selectedCycle)}
              disabled={isLoading || tier.name === 'free'}
              className={`w-full py-2 rounded-lg font-semibold transition-all ${
                tier.name === 'free'
                  ? 'bg-gray-300 text-gray-500 cursor-not-allowed'
                  : tier.name === currentTierName
                  ? 'bg-gray-300 text-gray-700 cursor-not-allowed'
                  : 'btn btn-secondary'
              }`}
            >
              {tier.name === 'free' ? 'Free Plan' : tier.name === currentTierName ? 'Current' : 'Upgrade'}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}