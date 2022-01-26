#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with root'
   exit 1
fi

read -p 'Enter username: ' USER_NAME

read -p 'Enter user description: ' COMMENT

read -p 'Enter password: ' PASS

useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ "$?" -ne 0 ]]
then
   echo 'The account could not be created'
   exit 1
fi

echo ${PASS} | passwd --stdin ${USER_NAME}

if [[ ${?} -ne 0 ]]
then
   echo 'The password could not be set'
   exit 1
fi

passwd -e ${USER_NAME}

echo
echo "username: ${USER_NAME}"
echo "password: ${PASS}"
echo "hostname: ${HOSTNAME}"
exit 0

