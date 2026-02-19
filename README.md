# Roaming Bear Honey Co.

A modern e-commerce platform and community hub for sustainable, wild-crafted honey. Built with Astro, React, and Supabase to showcase products, manage subscriptions, engage with the community, and tell the story of rewilding efforts.

## Features

- **Product Showcase** - Explore wild-crafted, sustainably-produced honey and merchandise
- **Subscription Program** - "Friends of the Bear" membership tiers with tiered benefits
  - Free tier access to community content
  - Member tier with monthly honey deliveries
  - Supporter tier with exclusive merchandise and discounts
  - Custom billing cycles (monthly, 6-month, yearly)
- **Member Portal** - Authenticated dashboard for managing subscriptions, orders, and profile
- **Blog** - Share knowledge about sustainable beekeeping and community impact
- **User Authentication** - Secure sign-up/login with email confirmation and Google OAuth
- **Real-time Updates** - Live data synchronization for subscriptions and orders

## Tech Stack

| Area | Technology |
|------|-----------|
| Frontend | [Astro 5](https://astro.build) + [React 19](https://react.dev) + [TypeScript](https://www.typescriptlang.org) |
| Styling | [Tailwind CSS 4](https://tailwindcss.com) |
| Backend | [Supabase](https://supabase.com) (PostgreSQL, Auth, Realtime) |
| Payments | [Stripe](https://stripe.com) |
| Email/CRM | [Brevo](https://www.brevo.com) |
| Icons | [Lucide React](https://lucide.dev) |

## Getting Started

### Prerequisites

- Node.js 18+ and npm
- Supabase project (free tier available)
- Environment variables configured

### Installation

1. Clone the repository:
```bash
git clone https://github.com/roamingbearhoneyco/roamingbearhoneyco.github.io.git
cd roamingbearhoneyco.github.io
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file with your configuration:
```
PUBLIC_SUPABASE_URL=your_supabase_url
PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. Start the development server:
```bash
npm run dev
```

The site will be available at `http://localhost:3000`

## Development

### Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build static site for production
- `npm run preview` - Preview production build locally

### Project Structure

```
src/
├── pages/           # Route-based pages (Astro + React)
├── components/      # Reusable React and Astro components
├── layouts/         # Page layouts
├── lib/            # Utilities (Supabase client)
├── utils/          # Helper functions
├── styles/         # Global styles
└── assets/         # Images and media

supabase/
├── migrations/      # Database schema migrations
└── config.toml      # Supabase configuration
```

### Key Pages

- **`/`** - Homepage with hero section and brand story
- **`/about`** - About the company, mission, and team
- **`/shop`** - Product listings and merchandise
- **`/blog`** - Articles on sustainable beekeeping and community impact
- **`/portal`** - Member dashboard (authentication required)
- **`/register`** - User sign-up with email or Google OAuth
- **`/signin`** - User login

## Architecture

### Frontend
- Astro handles static generation and server-side rendering
- React components provide interactivity (forms, dashboards, authentication)
- TypeScript ensures type safety

### Backend
- Supabase provides PostgreSQL database, user authentication, and real-time subscriptions
- Automated migrations set up profiles, subscriptions, and email integrations
- Edge functions and triggers automate business logic

### Authentication Flow
1. Users register with email/password or Google OAuth
2. Email confirmation required before access
3. Supabase auth tokens manage sessions
4. Protected routes use Auth gate components

## Contributing

We welcome contributions! Please feel free to:
- Report issues and bugs
- Suggest new features or improvements
- Submit pull requests with enhancements

## Deployment

The site is deployed on GitHub Pages using custom domain configuration (see `public/CNAME`).

Build output is generated to the `dist/` directory during `npm run build`.

## License

This project is licensed under the MIT License - see individual files for details.

## Contact & Support

For questions or support regarding this project, please open an issue on the GitHub repository.

---

**Made with 🍯 by Roaming Bear Honey Co.**

Celebrating sustainable beekeeping, rewilding efforts, and community connection.
