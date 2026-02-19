# Roaming Bear Honey Co. Design System

> **Reference this document when adding features, building new pages, or styling components.** All design tokens, components, and patterns live in `src/styles/global.css` and `src/layouts/`.

---

## Overview

This design system provides a unified approach to styling across the Roaming Bear Honey Co. website. It uses CSS custom properties (variables) for consistent theming, Tailwind v4 for utilities, and Astro + React for the stack.

**Key files:**
- `src/styles/global.css` — Design tokens, base styles, components, animations
- `src/layouts/Layout.astro` — Main layout (header, footer, nav)
- `src/layouts/BlogLayout.astro` — Blog listing layout
- `src/layouts/PostLayout.astro` — Individual blog post layout

---

## Brand & Contact

- **Company:** Roaming Bear Honey Co.
- **Tagline:** Local. Sustainable. Wild-crafted honey from the forest to your table.
- **Location:** Virginia
- **Contact:** roamingbearhoneyco@gmail.com
- **Site:** https://roamingbearhoneyco.com

---

## Brand Colors

### Primary Colors
| Token | Hex | Use |
|-------|-----|-----|
| `--color-forest-green` | #19360e | Primary brand, headers, primary actions |
| `--color-honey-amber` | #a05d35 | Secondary brand, accents, hover states |
| `--color-warm-cream` | #fff8ef | Background |
| `--color-dark-brown` | #2C1C0F | Primary text |

### Secondary Colors
| Token | Hex | Use |
|-------|-----|-----|
| `--color-golden-honey` | #d7af79 | Accent, highlights, borders |
| `--color-soft-amber` | #f5e7d0 | Overlays, subtle backgrounds |
| `--color-deep-forest` | #1d1d1b | Dark contrast |
| `--color-rich-earth` | #3e2e1d | Secondary text |
| `--color-vintage-wood` | #271d12 | Tertiary text |

### Semantic Aliases
- `--color-primary` → forest-green
- `--color-secondary` → honey-amber
- `--color-accent` → golden-honey
- `--color-background` → warm-cream
- `--color-text-primary` → dark-brown
- `--color-text-secondary` → rich-earth
- `--color-text-light` → warm-cream

---

## Typography

### Font Family
- **Primary:** `'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif`
- **Display:** `'Inter', system-ui, sans-serif`

Inter is loaded from Google Fonts with `display=swap` in `Layout.astro`.

### Scale
| Element | Size | Use |
|---------|------|-----|
| h1 | `clamp(2rem, 5vw, 3.5rem)` | Hero titles |
| h2 | `clamp(1.5rem, 4vw, 2.5rem)` | Section headers |
| h3 | `clamp(1.25rem, 3vw, 2rem)` | Subsections |
| h4 | `clamp(1.125rem, 2.5vw, 1.5rem)` | Card titles |
| h5 | `1.125rem` | Small headers |
| h6 | `1rem` | Micro headers |
| p | `1rem` | Body text |

---

## Spacing Scale

| Token | Value |
|-------|-------|
| `--space-xs` | 0.25rem |
| `--space-sm` | 0.5rem |
| `--space-md` | 1rem |
| `--space-lg` | 1.5rem |
| `--space-xl` | 2rem |
| `--space-2xl` | 3rem |
| `--space-3xl` | 4rem |

---

## Border Radius

| Token | Value |
|-------|-------|
| `--radius-sm` | 0.375rem |
| `--radius-md` | 0.5rem |
| `--radius-lg` | 0.75rem |
| `--radius-xl` | 1rem |
| `--radius-2xl` | 1.5rem |

---

## Shadows

| Token | Use |
|-------|-----|
| `--shadow-sm` | Small shadow |
| `--shadow-md` | Medium shadow |
| `--shadow-lg` | Large shadow (cards) |
| `--shadow-xl` | Extra large (card hover) |
| `--shadow-2xl` | 2X large |

---

## Transitions

| Token | Value |
|-------|-------|
| `--transition-fast` | 150ms ease-in-out |
| `--transition-normal` | 300ms ease-in-out |
| `--transition-slow` | 500ms ease-in-out |

---

## Z-Index Scale

| Token | Value | Use |
|-------|-------|-----|
| `--z-dropdown` | 1000 | Dropdowns |
| `--z-sticky` | 1020 | Sticky header, footer |
| `--z-fixed` | 1030 | Fixed elements |
| `--z-modal-backdrop` | 1040 | Modal backdrops |
| `--z-modal` | 1050 | Modals |
| `--z-popover` | 1060 | Popovers |
| `--z-tooltip` | 1070 | Tooltips |

---

## Layouts

### Layout.astro (Main)

Use for all main pages. Accepts optional props:

```astro
<Layout title="About" description="Learn about Roaming Bear Honey Co.">
  <slot />
</Layout>
```

- **title** — Page title. Default: "Roaming Bear Honey Co." If provided, becomes `{title} | Roaming Bear Honey Co.`
- **description** — Meta description for SEO. Optional.

Includes: header (sticky), main slot, footer. Imports `global.css`.

### BlogLayout.astro

Fixed background + gradient overlay. Use for blog listing (`/blog/[page]`).

### PostLayout.astro

Use for individual blog posts. Accepts frontmatter (title, date, author, category, description, image).

---

## Page Structure Pattern

Most content pages use this structure:

```astro
<Layout title="Page Name" description="...">
  <!-- 1. Fixed background image -->
  <div class="fixed inset-0 z-0 bg-center bg-cover" style="background-image: url('/assets/your-bg.png');"></div>

  <!-- 2. Gradient overlay -->
  <div class="fixed inset-0 z-10 bg-gradient-to-b from-[var(--color-soft-amber)]/80 to-[var(--color-golden-honey)]/40"></div>

  <!-- 3. Hero (optional) -->
  <section class="hero fade-in-up">
    <h1 class="hero-title text-gradient">Title</h1>
    <p class="hero-subtitle">Subtitle</p>
  </section>

  <!-- 4. Content (z-20 or z-30 so it sits above overlay) -->
  <section class="relative z-20 section-spacing px-4 sm:px-6">
    <div class="container-responsive">
      <!-- content -->
    </div>
  </section>
</Layout>
```

**Background options:**
- `bg-overlay` — Standard overlay from `global.css` (index)
- Custom gradient — e.g. `from-[var(--color-soft-amber)]/80 to-[var(--color-golden-honey)]/40`

---

## Footer Structure

The footer (in `Layout.astro`) has:

1. **Brand block** — Logo link, tagline, Virginia line
2. **Navigation grid** — Three columns:
   - **Explore:** Home, About, Blog, Shop
   - **Members:** Portal, Onboard, Sign In
   - **Legal:** Privacy Policy (`/privacy`), Terms & Conditions (`/terms`)
3. **Bottom bar** — Copyright, tech stack line

**Legal links are required** for Google OAuth branding. Do not remove them.

---

## Components

### Buttons

```html
<a href="/shop" class="btn btn-primary">Shop Now</a>
<button class="btn btn-secondary">Secondary</button>
<a href="/about" class="btn btn-outline">Outline</a>
```

Variants: `btn-primary`, `btn-secondary`, `btn-outline`

### Cards

```html
<!-- Standard card -->
<div class="card">
  <h2>Title</h2>
  <p>Content...</p>
</div>

<!-- Card with entrance animation (signin, portal welcome card) -->
<div class="card card-grow-in">
  <p>Pulses/bounces in on load</p>
</div>

<!-- Glass effect -->
<div class="glass">...</div>
```

### Forms

```html
<label class="form-label">Email</label>
<input type="email" class="form-input" placeholder="Enter your email">
```

### Navigation

```html
<a href="/about" class="nav-link">About</a>
```

### Hero

```html
<section class="hero fade-in-up">
  <h1 class="hero-title text-gradient">Welcome</h1>
  <p class="hero-subtitle">Subtitle</p>
</section>
```

Optional: add `text-gradient` to `hero-title` for gradient text.

---

## Animation Classes

| Class | Effect |
|-------|--------|
| `fade-in-up` | Fade in + translateY(30px → 0) |
| `fade-in` | Opacity 0 → 1 |
| `slide-in-left` | Slide from left |
| `slide-in-right` | Slide from right |
| `card-grow-in` | **Pulse/bounce in** — scale 0.4 → 1.08 → 0.98 → 1, with bounce easing. Use for signin form card, portal welcome card. |

**When to use `card-grow-in`:**
- Signin form card
- Portal "Welcome back" card
- Any card that should animate in with a pulse/bounce effect

**Guideline:** Add new animations in `global.css` under `@layer utilities`. Do not duplicate keyframes in page `<style>` blocks.

---

## Section Spacing Utilities

| Class | Use |
|-------|-----|
| `section-spacing` | Standard section padding (3xl top/bottom) |
| `section-spacing-lg` | Same as section-spacing |
| `section-spacing-md` | 2xl top/bottom |
| `section-spacing-sm` | xl top/bottom |
| `section-hero-content` | Compact top, 3xl bottom — use after hero |

---

## Utility Classes

| Class | Use |
|-------|-----|
| `text-gradient` | Gradient text (secondary → accent) |
| `border-accent` | Left border accent (4px secondary) |
| `shadow-brand` | Brand shadow |
| `container-responsive` | Max-width 1200px, responsive padding |

---

## Legal Pages

- **`/privacy`** — Privacy Policy (Google OAuth compliant)
- **`/terms`** — Terms & Conditions

Both use `Layout.astro` with `title` and `description`. Content is in a `card` with `border-accent` header. Governing law: Virginia. Contact: roamingbearhoneyco@gmail.com.

---

## Usage Guidelines

### Adding a New Page

1. Use `Layout.astro` with `title` and `description` props.
2. Follow the page structure pattern (background layers, content section).
3. Use `container-responsive` for content width.
4. Use design tokens (`var(--color-*)`) instead of hardcoded colors.

### Adding a New Component

1. Prefer design system classes (`.card`, `.btn`, etc.).
2. Add new reusable classes in `global.css` under `@layer components` or `@layer utilities`.
3. Use CSS variables for colors, spacing, radius.

### Images

- Always set `width` and `height` to avoid CLS.
- Use `loading="lazy"` for below-the-fold images.

### Static vs React

- Prefer static Astro pages for best load performance.
- Use `client:only="react"` only where needed (auth forms, dashboard). These pages will show a brief shell until React hydrates.

---

## Migration Notes

### From Hardcoded Colors
- `#19360e` → `var(--color-primary)`
- `#a05d35` → `var(--color-secondary)`
- `#fff8ef` → `var(--color-background)`
- `#2C1C0F` → `var(--color-text-primary)`

### From Tailwind Utilities
- `bg-white rounded-lg shadow-lg` → `card`
- `px-4 py-2 bg-blue-500 text-white` → `btn btn-primary`
- `text-gray-700` → `text-[var(--color-text-secondary)]`

---

## Related Docs

- **`docs/BEST-PRACTICES.md`** — Performance, SEO, avoiding content jumps, GitHub Pages, Supabase
