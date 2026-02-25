import { useEffect, useState, useRef } from 'react';
import { supabase } from '../lib/supabase';

interface User {
  email: string;
}

export default function UserAuth() {
  const [user, setUser] = useState<User | null>(null);
  const [isOpen, setIsOpen] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const checkAuth = async () => {
      const { data: { user: authUser } } = await supabase.auth.getUser();
      setUser(authUser ? { email: authUser.email || '' } : null);
      setIsLoading(false);
    };

    checkAuth();

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ? { email: session.user.email || '' } : null);
    });

    return () => {
      subscription?.unsubscribe();
    };
  }, []);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    };

    if (isOpen) {
      document.addEventListener('mousedown', handleClickOutside);
      return () => document.removeEventListener('mousedown', handleClickOutside);
    }
  }, [isOpen]);

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    setUser(null);
    setIsOpen(false);
    window.location.href = '/';
  };

  if (isLoading) {
    return (
      <div className="w-10 h-10 rounded-full bg-[var(--color-accent)]/30 animate-pulse" />
    );
  }

  if (!user) {
    // Logged out state - bear icon links to signin
    return (
      <a
        href="/signin"
        className="inline-flex items-center justify-center w-10 h-10 sm:w-11 sm:h-11 rounded-full hover:bg-white/20 active:bg-white/30 transition-colors duration-200 text-white"
        title="Sign In"
      >
        <span className="text-lg sm:text-xl font-bold leading-none">🐻</span>
      </a>
    );
  }

  // Logged in state - icon with dropdown - LARGER AND FILLED
  return (
    <div className="relative" ref={dropdownRef}>
      <button
        onClick={() => setIsOpen(!isOpen)}
        className="inline-flex items-center justify-center w-10 h-10 sm:w-11 sm:h-11 rounded-full hover:bg-white/20 active:bg-white/30 transition-colors duration-200 text-white"
        type="button"
        aria-label="User menu"
        aria-expanded={isOpen}
      >
        <span className="text-lg sm:text-xl font-bold leading-none">🐻</span>
      </button>

      {/* Dropdown Menu */}
      {isOpen && (
        <div
          className="absolute right-0 mt-2 w-56 rounded-lg border border-[rgba(215,175,121,0.15)] bg-[rgba(255,255,255,0.95)] backdrop-blur-xl shadow-xl z-[var(--z-dropdown)] animate-in fade-in-0 zoom-in-95 slide-in-from-top-2 duration-200"
          role="menu"
        >
          {/* User email display */}
          <div className="px-4 py-3 border-b border-[var(--color-accent)]/10">
            <p className="text-xs text-[var(--color-text-secondary)]">Signed in as</p>
            <p className="text-sm font-semibold text-[var(--color-text-primary)] truncate">
              {user.email}
            </p>
          </div>

          {/* Menu items */}
          <div className="py-2">
            <a
              href="/portal"
              className="block px-4 py-2 text-sm text-[var(--color-text-primary)] hover:bg-[var(--color-accent)]/10 transition-colors duration-150 rounded-md"
              role="menuitem"
              onClick={() => setIsOpen(false)}
            >
              Dashboard
            </a>

            <button
              onClick={handleSignOut}
              className="w-full text-left px-4 py-2 text-sm text-[#d74a4a] hover:bg-[#d74a4a]/10 transition-colors duration-150 rounded-md"
              role="menuitem"
            >
              Sign Out
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
