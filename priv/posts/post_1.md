---
title: Creating a Node package for ABI files
date: 2019-08-15
intro: Generating an NPM package from smart contract ABI files
---

Generating `index.js` for a static file Node package, for example smart contract ABI files:

```bash
#!/bin/sh
set -o errexit -o nounset -o pipefail

cat <<EOF >> index.js
let contracts = {
EOF

for file in ./artifacts/*.json; do
  echo "  '$(basename $file .json)': require('$file'),"
done >> index.js

cat <<EOF >> index.js
};

module.exports = contracts;
EOF
```
