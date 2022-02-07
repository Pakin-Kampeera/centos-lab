#!/bin/bash

log() {
  local MESSAGE="${@}"
  if [[ ${VERBOSE} ]]
  then
     echo "${MESSAGE}"
  fi
  logger -t 5lab.sh "${MESSAGE}"
}

backup() {
   local FILE="${1}"
   if [[ -f "${FILE}" ]]
   then
      local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
      log "Backing up ${FILE} to ${BACKUP_FILE}"
      cp -p ${FILE} ${BACKUP_FILE}
   else
      return 1
   fi
}

readonly VERBOSE=true
backup '/etc/passwd'

if [[ "${?}" -eq 0 ]]
then
   log 'File backup succeeded!'
else
   log 'File backup failed!'
   exit 1
fi
