#!/bin/bash


source ../default.sh
info "Install K3S cluster"
export INSTALL_K3S_EXEC="server --no-deploy traefik"
curl -sfL https://get.k3s.io | sh -


info "Add Kubeconfig"
sudo chmod 666 -R /etc/rancher/k3s
mkdir -p ~/.kube
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
