#!/bin/bash

echo "Deploy your AKS HELLO WORLD"

echo "$(terraform output kube_config)" > ./azurek8s.config

# Detect the operating system
os_type=$(uname)

if [[ "$os_type" == "Linux" ]]; then
  echo "Running on Linux"
  sed -i '/^<<EOT$/d; /^EOT$/d' ./azurek8s.config
elif [[ "$os_type" == "Darwin" ]]; then
  echo "Running on macOS"
  sed -i '' '/^<<EOT$/d; /^EOT$/d' ./azurek8s.config
else
  echo "Unsupported OS: $os_type"
  exit 1
fi

export KUBE_CONFIG_PATH=./azurek8s.config 
kubectl --kubeconfig ./azurek8s.config  apply -f k8s/
