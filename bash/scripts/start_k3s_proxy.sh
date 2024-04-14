#!/bin/bash

CURRENT_DIR=$(dirname "${0}")
source "${CURRENT_DIR}/../../default.sh"

info "start k3s proxy containers"
"${CURRENT_DIR}/../../cluster/traffic/install.sh"