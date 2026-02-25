import { useState, useEffect } from 'react';
import NewsletterModal from './NewsletterModal';
import ShopModal from './ShopModal';

export default function HomepageModals() {
  const [isNewsletterOpen, setIsNewsletterOpen] = useState(false);
  const [isShopOpen, setIsShopOpen] = useState(false);

  useEffect(() => {
    const browseShopBtn = document.getElementById('browse-shop-btn');
    const subscribeBtn = document.getElementById('subscribe-btn');

    const handleShopClick = (e: Event) => {
      e.preventDefault();
      setIsShopOpen(true);
    };

    const handleSubscribeClick = (e: Event) => {
      e.preventDefault();
      setIsNewsletterOpen(true);
    };

    browseShopBtn?.addEventListener('click', handleShopClick);
    subscribeBtn?.addEventListener('click', handleSubscribeClick);

    return () => {
      browseShopBtn?.removeEventListener('click', handleShopClick);
      subscribeBtn?.removeEventListener('click', handleSubscribeClick);
    };
  }, []);

  return (
    <>
      <NewsletterModal isOpen={isNewsletterOpen} onClose={() => setIsNewsletterOpen(false)} />
      <ShopModal isOpen={isShopOpen} onClose={() => setIsShopOpen(false)} />
    </>
  );
}
