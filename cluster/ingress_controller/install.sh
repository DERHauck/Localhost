#!/bin/bash

NAMESPACE="ingress"
NAME="default"


info "Install Ingress Controller"
debug "current dir ${PWD}"

debug "check namespace"
kubectl get namespace "${NAMESPACE}" &> /dev/null || kubectl create namespace "${NAMESPACE}"

debug "add helm repo"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

debug "check chart"
helm list -n "${NAMESPACE}" -f "${NAME}"
RESULT=${?}

debug "install chart - ${NAME}"
if [ "${RESULT}" == 1 ];
then
  helm install "${NAME}" ingress-nginx/ingress-nginx -f values-changes.yaml -n "${NAMESPACE}"
else
  debug "chart is already installed - ${NAME}"
fi

debug "upgrade chart - ${NAME}"
if [ "${RESULT}" == 0 ];
then
  helm upgrade "${NAME}" ingress-nginx/ingress-nginx -f values-changes.yaml -n "${NAMESPACE}"
else
  debug "no need to upgrade, just installed chart - ${NAME}"
fi
