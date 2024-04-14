#!/bin/bash

CURRENT_DIR=$(dirname "${0}")
source "${CURRENT_DIR}/../../default.sh"

if [ -z "${NAMESPACE}" ]; then NAMESPACE="external-dns"; fi
if [ -z "${NAME}" ]; then NAME="default"; fi
if [ -z "${API_TOKEN}" ]; then error "requires cloudflare 'API_TOKEN' to be set"; exit 1; fi
if [ -z "${NAME}" ]; then error "requires cloudflare 'API_EMAIL' to be set"; exit 1; fi

info "Install External DNS"
VERSION=1.14.4

debug "add helm repository"
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

debug "check namespace"
kubectl get namespace "${NAMESPACE}" &> /dev/null || kubectl create namespace "${NAMESPACE}"

debug "check chart"
helm status -n "${NAMESPACE}" "${NAME}"
RESULT=${?}

if [ "${RESULT}" != 0 ];
then
  debug "install chart - ${NAME}"
  helm install  "${NAME}" external-dns/external-dns -f values-changes.yaml -n "${NAMESPACE}" --version "${VERSION}" --set env[0].name=CF_API_TOKEN --set env[0].value="${API_TOKEN}" --set env[1].name=CF_API_EMAIL --set env[1].value="${API_EMAIL}"
else
  debug "upgrade chart - ${NAME}"
  helm upgrade "${NAME}" external-dns/external-dns -f values-changes.yaml -n "${NAMESPACE}" --version "${VERSION}" --set env[0].name=CF_API_TOKEN --set env[0].value="${API_TOKEN}" --set env[1].name=CF_API_EMAIL --set env[1].value="${API_EMAIL}"
fi

