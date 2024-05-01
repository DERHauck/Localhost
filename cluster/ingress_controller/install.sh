#!/bin/bash

CURRENT_DIR=$(realpath "${0}" | xargs dirname)
source "${CURRENT_DIR}/../../default.sh"


if [ -z "${NAMESPACE}" ]; then NAMESPACE="ingress"; fi
if [ -z "${CHART_NAME}" ]; then CHART_NAME="default"; fi


info "Install Ingress Controller"
debug "current dir ${PWD}"

debug "check namespace"
kubectl get namespace "${NAMESPACE}" &> /dev/null || kubectl create namespace "${NAMESPACE}"

debug "add helm repo"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
ARGS="--set controller.extraArgs.default-ssl-certificate='${CERT_NAMESPACE}/${CERT_NAME}'"
debug "check chart"
helm status -n "${NAMESPACE}" "${CHART_NAME}"
RESULT=${?}
debug "ARGS=${ARGS}"
if [ "${RESULT}" != 0 ];
then
  debug "install chart - ${CHART_NAME}"
  bash -c "helm install ${CHART_NAME} ingress-nginx/ingress-nginx -f values-changes.yaml -n ${NAMESPACE} ${ARGS}"
else
  debug "upgrade chart - ${CHART_NAME}"
  bash -c "helm upgrade ${CHART_NAME} ingress-nginx/ingress-nginx ${ARGS} -f values-changes.yaml -n ${NAMESPACE} "
fi