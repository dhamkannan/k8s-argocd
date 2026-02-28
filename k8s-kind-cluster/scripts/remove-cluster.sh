#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${1:-local}"

export KIND_EXPERIMENTAL_PROVIDER=podman

echo "Deleting cluster '${CLUSTER_NAME}'..."
kind delete cluster --name "${CLUSTER_NAME}"
echo "Done."
