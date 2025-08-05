// src/components/DashboardClient.tsx
import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'

export default function DashboardClient() {
  const [email, setEmail] = useState<string | null>(null)

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (!session) {
        window.location.href = '/signin'
      } else {
        setEmail(session.user.email ?? null)
      }
    })
  }, [])

  const handleSignOut = async () => {
    await supabase.auth.signOut()
    window.location.href = '/signin'
  }

  return (
    <>
      <h1 id="welcome-message">
        {email ? `Welcome ${email}` : 'Loading...'}
      </h1>
      <p>We’re happy to see you here</p>
      <button id="signout" onClick={handleSignOut}>
        Sign out
      </button>
    </>
  )
}
