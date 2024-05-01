#!/bin/bash


CURRENT_DIR=$(realpath "${0}" | xargs dirname)
source "${CURRENT_DIR}/../default.sh"

BOOTSTRAP_DIR=${CURRENT_DIR}

info "Component Cert Manager"
cd cert_manager || exit 1
NAMESPACE="certification"
CHART_NAME="default"
source install.sh
cd "${BOOTSTRAP_DIR}" || exit 1

info "Component Ingress Controller"

cd ingress_controller || exit 1
CERT_NAME=${CHART_NAME}
CERT_NAMESPACE=${NAMESPACE}
NAMESPACE="ingress"
CHART_NAME="default"
source install.sh
cd "${BOOTSTRAP_DIR}" || exit 1

cd traffic || exit 1
source install.sh
cd "${BOOTSTRAP_DIR}" || exit 1

