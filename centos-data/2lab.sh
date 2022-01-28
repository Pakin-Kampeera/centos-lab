#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
   echo "Please run with root" >&2
   exit 1
fi

if [[ "${#}" -lt 1 ]]
then
   echo "Require USERNAME and COMMENT to create account" >&2
   exit 1
fi

USER_NAME=${1}

shift
COMMENT=${@}

SPECIAL=$(echo "!@#$%^&*()_+" | fold -w1 | shuf | head -n1)
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)${SPECIAL}

useradd -c "${COMMENT}" -m "${USER_NAME}" &> /dev/null 

if [[ "${?}" -eq 1 ]]
then
   echo "The account could not be set" >&2
   exit 1
fi

passwd -e "${USER_NAME}" &> /dev/null

echo "Username: ${USER_NAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"
exit 0


