#!/bin/bash

CURRENT_DIR=$(dirname ${0})
source "${CURRENT_DIR}/../../default.sh"

info "Set up traffic redirect to cluster"

debug "get node ip address"
IP_ADDRESS=$(kubectl get service -n ingress default-ingress-nginx-controller -o json | jq '.status.loadBalancer.ingress | .[0].ip' -r)
export IP_ADDRESS="${IP_ADDRESS}"

debug "node address: ${IP_ADDRESS}"

debug "redirect traffic"
docker-compose -f "${CURRENT_DIR}/docker-compose.yaml" up -d