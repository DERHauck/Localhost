#!/bin/bash

source ../default.sh
info "Component Ingress Controller"
BOOTSTRAP_DIR=${PWD}

cd ingress_controller || exit 1
source install.sh
cd "${BOOTSTRAP_DIR}" || exit 1

cd traffic || exit 1
source install.sh
cd "${BOOTSTRAP_DIR}" || exit 1
