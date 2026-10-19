import primeui from 'tailwindcss-primeui';
import animate from 'tailwindcss-animate';

/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        swiss: {
          bg: '#FFFFFF',
          line: '#111827',
          orange: '#FF4D00',
          blue: '#0057FF',
          green: '#00B86B',
          ink: '#0F172A',
          muted: '#475569'
        }
      },
      fontFamily: {
        sans: ['Inter', 'Geist', 'Helvetica', 'Arial', 'sans-serif']
      }
    }
  },
  plugins: [primeui, animate]
};
