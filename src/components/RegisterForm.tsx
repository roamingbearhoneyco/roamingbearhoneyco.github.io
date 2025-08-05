// src/components/RegisterForm.tsx
import { useEffect } from 'react'
import { supabase } from '../lib/supabase'

export default function RegisterForm() {
  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      if (session) {
        window.location.href = '/dashboard'
      }
    })
  }, [])

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    const form = e.currentTarget
    const email = (form.elements.namedItem('email') as HTMLInputElement).value
    const password = (form.elements.namedItem('password') as HTMLInputElement).value

     // Determine redirect URL based on environment
    const redirectUrl =
      import.meta.env.MODE === 'development'
        ? 'http://localhost:4321/confirm'
        : 'https://testsite.roamingbearhoneyco.com/confirm'

     const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: redirectUrl,
      },
    })

    if (error) {
      alert(error.message)
    } else {
      alert('Confirmation email sent! Please check your inbox.')
    }
  }

  return (
    <form onSubmit={handleSubmit}>
      <label htmlFor="email">Email</label>
      <input type="email" name="email" id="email" required />
      <label htmlFor="password">Password</label>
      <input type="password" name="password" id="password" required />
      <button type="submit">Register</button>
    </form>
  )
}
