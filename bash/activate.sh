#!/bin/bash

source ../default.sh

info "start script"

SCRIPT=$1
ALIAS=$2

if [ -z "${SCRIPT}" ]; then error "No SCRIPT, add arg"; exit 1; fi

if [ -z "${ALIAS}" ]; then ALIAS=$(echo "${SCRIPT}" | xargs basename | awk -F".sh" '{print $1}' ); fi

info "SCRIPT=${SCRIPT} with ALIAS=${ALIAS}"

ln -s "${PWD}/${SCRIPT}" "path/${ALIAS}"