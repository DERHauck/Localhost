#!/bin/bash

source ../../default.sh

HOSTNAME=$(cat /etc/hostname | tr '[:upper:]' '[:lower:]')

info "Set up traffic redirect to cluster"

debug "get node ip address"
IP_ADDRESS=$(kubectl get node "${HOSTNAME}" -o json | jq '.status.addresses'  | jq -r '.[] | select(.type=="InternalIP") | .address')
export IP_ADDRESS="${IP_ADDRESS}"

debug "node address: ${IP_ADDRESS}"

debug "redirect traffic"
docker-compose up -d
