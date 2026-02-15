import { createClient } from "@supabase/supabase-js";

export const supabase = createClient(
  import.meta.env.PUBLIC_SUPABASE_URL,
  import.meta.env.PUBLIC_SUPABASE_ANON_KEY,
  {
    auth: {
      // 1. Switch to sessionStorage: login wipes when tab/browser closes
      // 2. The 'typeof window' check prevents crashes during builds (SSR)
      storage: typeof window !== 'undefined' ? window.sessionStorage : undefined,
      
      // Keep user logged in while they navigate between dashboard tabs
      persistSession: true,
      
      // Automatically refresh the login token in the background
      autoRefreshToken: true,
      
      // Detects if user clicked a 'Magic Link' or 'Password Reset' in their email
      detectSessionInUrl: true
    }
  }
);