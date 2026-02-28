#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${1:-local}"
CONFIG="$(dirname "$0")/../configs/kind-config.yaml"

export KIND_EXPERIMENTAL_PROVIDER=podman

echo "Creating cluster '${CLUSTER_NAME}'..."
kind create cluster --name "${CLUSTER_NAME}" --config "${CONFIG}"

echo "Done. Nodes:"
kubectl get nodes -o wide
