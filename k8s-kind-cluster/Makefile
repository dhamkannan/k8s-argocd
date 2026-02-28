CLUSTER_NAME ?= local

.PHONY: create delete status connect install-argocd setup-argocd

create:
	bash scripts/new-cluster.sh $(CLUSTER_NAME)

delete:
	bash scripts/remove-cluster.sh $(CLUSTER_NAME)

status:
	bash scripts/get-cluster-status.sh $(CLUSTER_NAME)

connect:
	kind export kubeconfig --name $(CLUSTER_NAME)
	kubectl config use-context kind-$(CLUSTER_NAME)
	kubectl cluster-info --context kind-$(CLUSTER_NAME)
	kubectl get nodes -o wide

install-argocd:
	helm repo add argo https://argoproj.github.io/argo-helm
	helm repo update
	helm install argo-cd argo/argo-cd \
	--version 9.4.5 \
	--namespace argocd \
	--create-namespace

setup-argocd:
	kubectl apply -f cluster/argocd/
	kubectl apply -f https://raw.githubusercontent.com/dhamkannan/k8s-argocd/v1/argo/root.yaml