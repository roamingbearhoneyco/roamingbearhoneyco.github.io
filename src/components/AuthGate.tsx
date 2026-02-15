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

  // While checking auth, render NOTHING (no flash)
  if (!authChecked) return null;

  // Auth confirmed → render dashboard
  return <>{children}</>;
}