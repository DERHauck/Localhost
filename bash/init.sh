#!/bin/bash

# add 'path' folder to shell
SHELL_CONFIG="$1"
LOCALHOST_PATH="${PWD}/path"

if [ -z "${SHELL_CONFIG}" ];
then
  SHELL_CONFIG=~/.bashrc
  echo "SHELL_CONFIG not set, defaulting to bash '~/.bashrc'"
fi

if echo "${PATH}" | grep "${LOCALHOST_PATH}" &> /dev/null
then
  echo "PATH already contains LOCALHOST_PATH -> ${LOCALHOST_PATH}"
  exit 0
fi

printf "\nPATH=\"%s:\${PATH}\"\n" "${LOCALHOST_PATH}" >> "${SHELL_CONFIG}"
# shellcheck disable=SC1090
source "${SHELL_CONFIG}"
printf  "Added %s to PATH variable\n" "${LOCALHOST_PATH}"