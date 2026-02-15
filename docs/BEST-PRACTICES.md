# Roaming Bear Honey Co. — Best Practices & Why the Home Page Loads Smoothly

## Why the home page (index.astro) loads smoothly

- **Fully static** — No `client:only` or client-side data fetching; the entire page is server-rendered HTML and CSS.
- **Critical CSS in layout** — `Layout.astro` imports `global.css`, so styles are in the same request and there’s no FOUC.
- **Fixed backgrounds** — Hero and overlays use `position: fixed` and `inset: 0`, so they don’t affect layout or cause CLS.
- **No late content swap** — All content is in the initial HTML; nothing is replaced by “Loading…” then real content.

Keeping other pages as static as possible (and avoiding unnecessary client islands) will keep them feeling like the home page.

---

## Changes applied in this pass

| Area | Change |
|------|--------|
| **Layout** | Added optional `title` and `description` props; all pages can set unique `<title>` and `<meta name="description">` for SEO. |
| **Animations** | Removed duplicate `@keyframes fadeInUp` / `.animate-fade-in-up` from index, shop, and about; they use the global `fade-in-up` from `global.css` only. |
| **Images (CLS)** | About page images now have `width`/`height` and the below-the-fold image uses `loading="lazy"`. |
| **Fonts** | Layout already uses `display=swap` on the Inter font link to avoid invisible text. |
| **Portal** | `AuthGate` now shows a same-height loading skeleton instead of `null` while auth is checked, so the page doesn’t collapse then jump. |

---

## Ongoing best practices

### 1. **global.css and design system**

- **Design tokens** — Brand colors, spacing, radius, shadows, and z-index live in `:root` and are used by Tailwind and components. Prefer these over new magic numbers.
- **Layers** — Use `@layer base`, `@layer components`, `@layer utilities` so Tailwind and custom styles compose predictably.
- **New animations** — Add keyframes and utility classes in `global.css` (e.g. under `@layer utilities`) instead of duplicating them in page `<style>` blocks.

### 2. **Layouts**

- **Layout.astro** — Use it for all main pages. Pass `title` and `description` for SEO (e.g. `<Layout title="About" description="...">`).
- **BlogLayout / PostLayout** — Use for blog listing and posts; they already handle background and prose.

### 3. **Avoiding content jumps**

- **Static-first** — Prefer Astro-only pages (like index, about, shop). Add React only where needed (auth, forms, dashboard).
- **client:only** — Used on signin, register, portal, etc. Those pages will show a brief shell until React hydrates. Portal now uses a skeleton inside `AuthGate` to keep height stable.
- **Images** — Always set `width` and `height` (or use a wrapper with `aspect-ratio`) so layout doesn’t shift when images load. Use `loading="lazy"` for below-the-fold images.

### 4. **GitHub Pages & Astro**

- **Static export** — Astro’s default is static output; ensure `astro build` is used and the output (e.g. `dist/`) is deployed.
- **Custom domain** — `astro.config.mjs` has `site: 'https://roamingbearhoneyco.com'`. If you use `username.github.io/repo`, set `base: '/repo-name/'` in the Astro config.

### 5. **Supabase**

- **Env vars** — Use `PUBLIC_SUPABASE_URL` and `PUBLIC_SUPABASE_ANON_KEY`; keep anon key public and use RLS for security.
- **Auth** — `supabase.ts` uses `sessionStorage`, `detectSessionInUrl`, and `autoRefreshToken`; no change needed for typical auth flows.

---

## Optional next steps

- **View Transitions** — For smoother navigation between static pages, consider `@astrojs/view-transitions` (optional; can affect behavior on client:only pages).
- **Image dimensions** — If you change about/shop images, update `width`/`height` to match actual asset dimensions for best CLS.
- **Blog and other pages** — Add `title` and `description` to any new layout or page that uses `Layout.astro`.
