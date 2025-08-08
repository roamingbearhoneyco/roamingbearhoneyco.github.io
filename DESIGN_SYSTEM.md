# Roaming Bear Honey Co. Design System

## Overview

This design system provides a unified approach to styling across the Roaming Bear Honey Co. website, using CSS custom properties (CSS variables) for consistent theming and modern component patterns.

## Brand Colors

### Primary Colors
- `--color-forest-green: #19360e` - Primary brand color, used for headers and primary actions
- `--color-honey-amber: #a05d35` - Secondary brand color, used for accents and hover states
- `--color-warm-cream: #fff8ef` - Background color, warm and inviting
- `--color-dark-brown: #2C1C0F` - Primary text color, deep and readable

### Secondary Colors
- `--color-golden-honey: #d7af79` - Accent color, used for highlights and borders
- `--color-soft-amber: #f5e7d0` - Light accent, used for overlays and subtle backgrounds
- `--color-deep-forest: #1d1d1b` - Dark variant for contrast
- `--color-rich-earth: #3e2e1d` - Secondary text color
- `--color-vintage-wood: #271d12` - Tertiary text color

### Semantic Colors
- `--color-primary: var(--color-forest-green)` - Primary brand color
- `--color-secondary: var(--color-honey-amber)` - Secondary brand color
- `--color-accent: var(--color-golden-honey)` - Accent color
- `--color-background: var(--color-warm-cream)` - Background color
- `--color-text-primary: var(--color-dark-brown)` - Primary text color
- `--color-text-secondary: var(--color-rich-earth)` - Secondary text color
- `--color-text-light: var(--color-warm-cream)` - Light text color

## Typography

### Font Family
- Primary: `'Inter', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif`
- Display: `'Inter', system-ui, sans-serif`

### Typography Scale
- `h1`: `clamp(2rem, 5vw, 3.5rem)` - Hero titles
- `h2`: `clamp(1.5rem, 4vw, 2.5rem)` - Section headers
- `h3`: `clamp(1.25rem, 3vw, 2rem)` - Subsection headers
- `h4`: `clamp(1.125rem, 2.5vw, 1.5rem)` - Card titles
- `h5`: `1.125rem` - Small headers
- `h6`: `1rem` - Micro headers
- `p`: `1rem` - Body text

## Spacing Scale

- `--space-xs: 0.25rem` - Extra small spacing
- `--space-sm: 0.5rem` - Small spacing
- `--space-md: 1rem` - Medium spacing
- `--space-lg: 1.5rem` - Large spacing
- `--space-xl: 2rem` - Extra large spacing
- `--space-2xl: 3rem` - 2X large spacing
- `--space-3xl: 4rem` - 3X large spacing

## Border Radius

- `--radius-sm: 0.375rem` - Small radius
- `--radius-md: 0.5rem` - Medium radius
- `--radius-lg: 0.75rem` - Large radius
- `--radius-xl: 1rem` - Extra large radius
- `--radius-2xl: 1.5rem` - 2X large radius

## Shadows

- `--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05)` - Small shadow
- `--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)` - Medium shadow
- `--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)` - Large shadow
- `--shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)` - Extra large shadow
- `--shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25)` - 2X large shadow

## Transitions

- `--transition-fast: 150ms ease-in-out` - Fast transitions
- `--transition-normal: 300ms ease-in-out` - Normal transitions
- `--transition-slow: 500ms ease-in-out` - Slow transitions

## Z-Index Scale

- `--z-dropdown: 1000` - Dropdown menus
- `--z-sticky: 1020` - Sticky elements
- `--z-fixed: 1030` - Fixed elements
- `--z-modal-backdrop: 1040` - Modal backdrops
- `--z-modal: 1050` - Modal dialogs
- `--z-popover: 1060` - Popovers
- `--z-tooltip: 1070` - Tooltips

## Components

### Buttons

#### Primary Button
```html
<a href="/shop" class="btn btn-primary">Shop Now</a>
```

#### Secondary Button
```html
<button class="btn btn-secondary">Sign Out</button>
```

#### Outline Button
```html
<a href="/about" class="btn btn-outline">Learn More</a>
```

### Cards

#### Standard Card
```html
<div class="card">
  <h2>Card Title</h2>
  <p>Card content goes here...</p>
</div>
```

#### Glass Effect Card
```html
<div class="glass">
  <h2>Glass Card</h2>
  <p>Content with glass effect...</p>
</div>
```

### Forms

#### Form Input
```html
<label class="form-label">Email</label>
<input type="email" class="form-input" placeholder="Enter your email">
```

### Navigation

#### Nav Link
```html
<a href="/about" class="nav-link">About</a>
```

### Hero Sections

#### Hero Container
```html
<section class="hero">
  <h1 class="hero-title">Welcome to Roaming Bear</h1>
  <p class="hero-subtitle">Your subtitle here</p>
</section>
```

### Background Overlays

#### Standard Overlay
```html
<div class="bg-overlay"></div>
```

## Utility Classes

### Text Utilities
- `.text-gradient` - Gradient text effect
- `.border-accent` - Left border accent
- `.shadow-brand` - Brand-specific shadow

### Animation Classes
- `.fade-in-up` - Fade in from bottom
- `.fade-in` - Simple fade in
- `.slide-in-left` - Slide in from left
- `.slide-in-right` - Slide in from right

### Responsive Utilities
- `.container-responsive` - Responsive container with proper padding

## Usage Guidelines

### Color Usage
1. **Primary Actions**: Use `--color-primary` for main CTAs and important buttons
2. **Secondary Actions**: Use `--color-secondary` for secondary buttons and links
3. **Accents**: Use `--color-accent` for highlights, borders, and hover states
4. **Text**: Use `--color-text-primary` for main text, `--color-text-secondary` for supporting text
5. **Backgrounds**: Use `--color-background` for main backgrounds

### Typography Guidelines
1. **Headers**: Use the appropriate heading level (h1-h6) with the predefined sizes
2. **Body Text**: Use `<p>` tags for body text
3. **Links**: Use `<a>` tags with the built-in hover effects
4. **Emphasis**: Use `<strong>` for bold text, `<em>` for italic text

### Component Guidelines
1. **Buttons**: Always use the `.btn` class with appropriate variant
2. **Cards**: Use `.card` for content containers
3. **Forms**: Use `.form-input` and `.form-label` for form elements
4. **Navigation**: Use `.nav-link` for navigation items

### Animation Guidelines
1. **Page Loads**: Use `.fade-in-up` for hero sections
2. **Content Reveal**: Use `.slide-in-left` or `.slide-in-right` for staggered content
3. **Hover Effects**: Built into components, no additional classes needed

## Browser Support

This design system uses modern CSS features including:
- CSS Custom Properties (CSS Variables)
- CSS Grid and Flexbox
- Backdrop Filter (with fallbacks)
- Clamp() function for responsive typography

All modern browsers (Chrome 88+, Firefox 87+, Safari 14+, Edge 88+) are supported.

## Migration Notes

### From Hardcoded Colors
Replace hardcoded colors with CSS custom properties:
- `#19360e` → `var(--color-primary)`
- `#a05d35` → `var(--color-secondary)`
- `#fff8ef` → `var(--color-background)`
- `#2C1C0F` → `var(--color-text-primary)`

### From Tailwind Classes
Replace Tailwind utility classes with design system classes:
- `bg-white rounded-lg shadow-lg` → `card`
- `px-4 py-2 bg-blue-500 text-white` → `btn btn-primary`
- `text-gray-700` → `text-[var(--color-text-secondary)]`

## Future Enhancements

1. **Dark Mode**: Add dark mode support with alternative color schemes
2. **Component Library**: Create a comprehensive component library
3. **Design Tokens**: Export design tokens for use in other tools
4. **Accessibility**: Add comprehensive accessibility guidelines
5. **Animation Library**: Expand animation options and guidelines
