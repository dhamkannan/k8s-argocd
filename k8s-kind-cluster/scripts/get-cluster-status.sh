#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${1:-local}"

kubectl config use-context "kind-${CLUSTER_NAME}"

echo "--- Nodes ---"
kubectl get nodes -o wide

echo ""
echo "--- kube-system pods ---"
kubectl get pods -n kube-system

echo ""
echo "--- Podman containers ---"
podman ps --filter "label=io.x-k8s.kind.cluster=${CLUSTER_NAME}"
