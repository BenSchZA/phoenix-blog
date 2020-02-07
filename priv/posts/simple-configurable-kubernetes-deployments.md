---
title: K.I.S.S Kubernetes deployment script
date: 2019-09-05
draft: false
intro: Simple bash deployment script for generating Kubernetes resource files and replacing environment variables.
---

Following this simple process, you can create configurable Kubernetes deployment definitions, without having to learn and use a tool like Helm:

1. Create a set of Kubernetes yaml resource files in your working directory, setting environment variables you'd like to replace: `$FOO` or `${BAR}`
2. Export the environment variables - the environment variable substitution using `envsubst` will fail if there are environment variables that aren't set.
3. Run the bash script, passing your working directory as the first argument `deploy.sh .`
4. This will generate a directory called `deployments/` with a timestamped directory containing the generated Kubernetes resource files. `kubectl apply -f --dry-run ...` is run with the `--dry-run` option to check that the resource definitions are valid. 
5. When you're happy and ready to apply the resource updates, run the same command without the dry-run option: `kubectl apply -f deployments/deploy_{date}`

```bash
#!/bin/sh -ex

OUTPUT_DIR=$1/deployments/deploy_$(date +%F-%T)
mkdir -p $OUTPUT_DIR

for FILE in $1/*.yaml
do
  echo "Creating deployment"
  envsubst <$FILE> $OUTPUT_DIR/$FILE
done

kubectl apply -f $OUTPUT_DIR --dry-run -o yaml > $OUTPUT_DIR/output.yaml
```
