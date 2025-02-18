const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        "slide-down-up": {
          "0%": {
            transform: "translateY(-100%)",
            opacity: "0",
          },
          "15%, 85%": {
            transform: "translateY(0)",
            opacity: "1",
          },
          "100%": {
            transform: "translateY(-100%)",
            opacity: "0",
          },
        },
      },
      animation: {
        "slide-down-up": "slide-down-up 3s ease-in-out forwards",
      },
    },
  },
  plugins: [
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
    require("daisyui"),
  ],
  daisyui: {
    themes: ["retro", "dracula"],
    darkTheme: "dracula",
    prefix: "",
  },
  safelist: ["text-error", { pattern: /input-+/ }, { pattern: /my-+/ }],
};
