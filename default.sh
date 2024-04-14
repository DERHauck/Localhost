#!/bin/bash

if [ -z "${LOG_LEVEL}" ]; then LOG_LEVEL="INFO"; fi
# DEBUG -> INFO -> ERROR
is_same() {
  if [ "$1" == "$2" ]; then return 0; else return 1; fi
}
loglevel() {
  case ${LOG_LEVEL} in
    "DEBUG")
      is_same "DEBUG" $1 || LOG_LEVEL="INFO" loglevel $1
      ;;
    "INFO")
      is_same "INFO" $1 || LOG_LEVEL="ERROR" loglevel $1
      ;;
    "ERROR")
      is_same "ERROR" $1
      ;;
    *)
      echo "NOPE"
      return 1
      ;;
  esac
}
log() {
  LEVEL=$1
  shift
  for MESSAGE in "$@";
  do
    printf "# %s:\t%s\n" "${LEVEL}" "${MESSAGE}"
  done
}

debug() {
  if loglevel "DEBUG"
  then
    log "DEBUG" "${@}"
  fi
}

info() {
  if loglevel "INFO"
  then
    log "INFO" "${@}"
  fi
}

error() {
  if loglevel "ERROR"
  then
    log "ERROR" "${@}"
  fi
}

PROJECT_ROOT=${0}

