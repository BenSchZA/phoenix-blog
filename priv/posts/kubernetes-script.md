---
title: "Simple Kubernetes deployment script"
date: 2019-09-05
draft: false
---

```
#!/bin/sh -ex

OUTPUT_DIR=deploy_$(date +%F-%T)
mkdir $OUTPUT_DIR

for FILE in $1/*.yaml
do
  echo "Creating deployment"
  envsubst <$FILE> $OUTPUT_DIR/$FILE
done

kubectl apply -f $OUTPUT_DIR --dry-run -o yaml > $OUTPUT_DIR/output.yaml
```
