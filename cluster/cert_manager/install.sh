#!/bin/bash

CURRENT_DIR=$(dirname "${0}")
source "${CURRENT_DIR}/../../default.sh"

if [ -z "${EMAIL_ADDRESS}" ]; then error "requires email address in var 'EMAIL_ADDRESS'"; exit 1; fi
if [ -z "${NAMESPACE}" ]; then NAMESPACE="certification"; fi
if [ -z "${CHART_NAME}" ]; then CHART_NAME="default"; fi

info "Install Cert Manager"


debug "add helm repository"
helm repo add jetstack https://charts.jetstack.io

debug "check namespace"
kubectl get namespace "${NAMESPACE}" &> /dev/null || kubectl create namespace "${NAMESPACE}"

debug "install cert manager CRDs v1.14.4"
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.crds.yaml

debug "check chart"
helm status -n "${NAMESPACE}" "${CHART_NAME}"
RESULT=${?}

if [ "${RESULT}" != 0 ];
then
  debug "install chart - ${CHART_NAME}"
  helm install "${CHART_NAME}" jetstack/cert-manager -f values-changes.yaml -n "${NAMESPACE}"
else
  debug "upgrade chart - ${CHART_NAME}"
  helm upgrade "${CHART_NAME}" jetstack/cert-manager -f values-changes.yaml -n "${NAMESPACE}"
fi


debug "add cluster issuer"
envsubst < localhost.cluster-issuer.yaml | kubectl apply -f - -n "${NAMESPACE}"