/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif']
      },
      colors: {
        info: '#3B82F6',
        warning: '#F59E0B',
        success: '#10B981',
      },
    },
  },
  plugins: [],
};
