---
title: Phoenix Framework, Earmark, and PrismJS
date: 2020-02-07
intro: How to get syntax highlighting of markdown in Phoenix using Earmark, PrismJS with Brunch and Babel
draft: false
---

Following this great tutorial https://alchemist.camp/articles/phoenix-prism-syntax-highlighting, I ran into a few outdated packages and dependancy issues setting up PrismJS in Phoenix.

Phoenix 1.3.4 comes with the Brunch JS build pipeline pre-installed.

When following the documentation for installing the Babel plugin for Brunch, they recommend installing the `babel-brunch` package, but this creates a dependancy error - Babel version `^7.0.0-0` is required.

`babel-brunch` has a dependancy on the outdated `babel-core` package, whereas `babel-brunch-7` depends on the `@babel/core` package with Babel version `^7.0.0-0`. We'll need to install `babel-brunch-7`.

```bash
yarn add prismjs
yarn add --dev babel-plugin-prismjs
yarn add --dev @babel/core
yarn add --dev @babel/preset-env
yarn add --dev babel-brunch-7
```

**OR**

```bash
npm install prismjs
npm install --save-dev babel-plugin-prismjs
npm install --save-dev @babel/core
npm install --save-dev @babel/preset-env
npm install --save-dev babel-brunch-7
```

With the default Phoenix Brunch config `brunch-config.js`, you can safely follow the rest of the Alchemist tutorial, ignoring the package versions mentioned:

```javascript
exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
```