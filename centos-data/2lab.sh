#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
   echo "Please run with root"
   exit 1
fi

if [[ "${#}" -lt 1 ]]
then
   echo "Require USERNAME and COMMENT to create account"
   exit 1
fi

USER_NAME=${1}

shift
COMMENT=${@}

SPECIAL=$(echo "!@#$%^&*()_+" | fold -w1 | shuf | head -n1)
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)${SPECIAL}

useradd -c "${COMMENT}" -m "${USER_NAME}"

if [[ "${?}" -eq 1 ]]
then
   echo "The account could not be set"
   exit 1
fi

passwd -e "${USER_NAME}"

echo "Username: ${USER_NAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"
exit 0


