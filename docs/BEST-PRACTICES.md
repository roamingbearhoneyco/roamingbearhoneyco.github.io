# Roaming Bear Honey Co. — Best Practices

> **Design system reference:** See [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md) for tokens, components, layouts, and usage guidelines.

---

## Why the Home Page Loads Smoothly

- **Fully static** — No `client:only` or client-side data fetching; entire page is server-rendered HTML and CSS.
- **Critical CSS in layout** — `Layout.astro` imports `global.css`, so styles load with the page (no FOUC).
- **Fixed backgrounds** — Hero and overlays use `position: fixed` and `inset: 0`, so they don't cause layout shift.
- **No late content swap** — All content is in the initial HTML; nothing is replaced by "Loading…" then real content.

**Guideline:** Keep other pages as static as possible. Add React only where needed (auth, forms, dashboard).

---

## Performance & Layout

### Static-First
- Prefer Astro-only pages (index, about, shop, privacy, terms).
- Use `client:only="react"` only for: signin, register, portal, onboard, confirm, reset.

### Avoiding Content Jumps
- **client:only pages** — Portal uses a loading skeleton in `AuthGate` so the page doesn't collapse while auth is checked.
- **Images** — Always set `width` and `height`. Use `loading="lazy"` for below-the-fold images.
- **Animations** — Add keyframes in `global.css`; don't duplicate in page `<style>` blocks.

### SEO
- Pass `title` and `description` to `Layout` on every page.
- Example: `<Layout title="About" description="Learn about Roaming Bear Honey Co.">`

---

## GitHub Pages & Astro

- **Static export** — Astro's default. Use `astro build`; deploy `dist/`.
- **Custom domain** — `astro.config.mjs` has `site: 'https://roamingbearhoneyco.com'`.
- **Repo path** — If using `username.github.io/repo`, set `base: '/repo-name/'` in Astro config.

---

## Supabase

- **Env vars** — `PUBLIC_SUPABASE_URL`, `PUBLIC_SUPABASE_ANON_KEY`. Use RLS for security.
- **Auth** — `supabase.ts` uses `sessionStorage`, `detectSessionInUrl`, `autoRefreshToken`.

---

## Optional Next Steps

- **View Transitions** — Consider `@astrojs/view-transitions` for smoother navigation (may affect client:only pages).
- **Image dimensions** — When changing about/shop images, update `width`/`height` to match actual assets.
