// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  site: 'https://testsite.roamingbearhoneyco.com',
  vite: {
    plugins: [tailwindcss()]
  }
});