# kind cluster

A local Kubernetes cluster using [kind](https://kind.sigs.k8s.io/) and [Podman](https://podman.io/), managed as code and deployed via Git Bash on Windows.

See [cluster/CONFIG.md](cluster/CONFIG.md) for all configuration decisions and their production equivalents.

## Topology

| Node | Role | Zone | Group |
|------|------|------|-------|
| `control-plane-1` | control-plane | zone-a | — |
| `control-plane-2` | control-plane | zone-b | — |
| `worker-1` | worker | zone-a | general |
| `worker-2` | worker | zone-b | general |
| `worker-3` | worker | zone-b | infra (tainted) |

## Prerequisites

| Tool | Install |
|------|---------|
| **Podman** | https://podman.io/docs/installation |
| **kind** | https://kind.sigs.k8s.io/docs/user/quick-start/#installation |
| **kubectl** | https://kubernetes.io/docs/tasks/tools/ |

## Quick start

```bash
# make scripts executable (one-off)
chmod +x scripts/*.sh

# create the cluster
./scripts/new-cluster.sh

# check status
./scripts/get-cluster-status.sh

# tear down
./scripts/remove-cluster.sh
```

Or with `make`:

```bash
make create
make status
make delete
```

Pass a custom cluster name as the first argument:

```bash
./scripts/new-cluster.sh dev
make create CLUSTER_NAME=dev
```

## File layout

```
.
├── cluster/
│   ├── kind-config.yaml        # cluster definition (IaC source of truth)
│   └── CONFIG.md               # configuration decisions and production equivalents
├── scripts/
│   ├── new-cluster.sh
│   ├── remove-cluster.sh
│   └── get-cluster-status.sh
└── Makefile
```
│   └── get-cluster-status.sh
└── Makefile
```

## Common operations

```bash
# switch kubectl to this cluster
kubectl config use-context kind-local

# list nodes
kubectl get nodes -o wide

# destroy and recreate from scratch
./scripts/remove-cluster.sh && ./scripts/new-cluster.sh
```

## Customising the cluster

Edit [cluster/kind-config.yaml](cluster/kind-config.yaml):

- **Pin a Kubernetes version** — uncomment the `image:` lines and set a tag from [Docker Hub](https://hub.docker.com/r/kindest/node/tags).
- **Add nodes** — duplicate a `- role: worker` block.
- **Expose ports** — add `extraPortMappings` under the control-plane node.
- **Mount host directories** — add `extraMounts` per node.

Example port mapping (add beneath the control-plane node):

```yaml
  - role: control-plane
    extraPortMappings:
      - containerPort: 30000
        hostPort: 30000
        protocol: TCP
```
