const purgecss = require("@fullhuman/postcss-purgecss")({
  content: ["../**/*.html.eex", "./js/**/*.js", "../**/*_view.ex"],
  defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || [],
  whitelistPatternsChildren: [/^token/, /^pre/, /^code/],
});

module.exports = {
    plugins: [
      require('tailwindcss'),
      require('autoprefixer'),
      ...(process.env.NODE_ENV === "production" ? [purgecss] : [])
    ]
  }