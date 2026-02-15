import { useEffect, useState } from "react";
import { supabase } from "../lib/supabase";

export default function AuthGate({ children }: { children: React.ReactNode }) {
  const [authChecked, setAuthChecked] = useState(false);
  const [isAuthed, setIsAuthed] = useState(false);

  useEffect(() => {
    const check = async () => {
      const { data: { user } } = await supabase.auth.getUser();

      if (!user) {
        window.location.href = "/signin";
        return; // stop here, never render children
      }

      setIsAuthed(true);
      setAuthChecked(true);
    };

    check();
  }, []);

  // While checking auth, render same-height skeleton to avoid layout shift (best practice)
  if (!authChecked) {
    return (
      <div className="relative z-20 pt-32 px-4 text-center section-spacing min-h-[24rem]">
        <div className="max-w-2xl mx-auto animate-pulse space-y-4" role="status" aria-label="Loading">
          <div className="h-10 bg-[var(--color-accent)]/20 rounded w-3/4 mx-auto" />
          <div className="h-4 bg-[var(--color-accent)]/10 rounded w-full" />
          <div className="h-4 bg-[var(--color-accent)]/10 rounded w-5/6 mx-auto" />
          <div className="h-32 bg-[var(--color-accent)]/10 rounded mt-8" />
        </div>
      </div>
    );
  }

  // Auth confirmed → render dashboard
  return <>{children}</>;
}