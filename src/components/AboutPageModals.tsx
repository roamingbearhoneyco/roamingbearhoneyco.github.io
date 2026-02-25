import { useState, useEffect } from 'react';
import NewsletterModal from './NewsletterModal';

export default function AboutPageModals() {
  const [isNewsletterOpen, setIsNewsletterOpen] = useState(false);

  useEffect(() => {
    const joinHiveBtn = document.getElementById('about-join-hive-btn');

    const handleJoinClick = (e: Event) => {
      e.preventDefault();
      setIsNewsletterOpen(true);
    };

    joinHiveBtn?.addEventListener('click', handleJoinClick);

    return () => {
      joinHiveBtn?.removeEventListener('click', handleJoinClick);
    };
  }, []);

  return (
    <NewsletterModal isOpen={isNewsletterOpen} onClose={() => setIsNewsletterOpen(false)} />
  );
}
