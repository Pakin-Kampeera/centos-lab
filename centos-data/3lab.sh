#!/bin/bash

FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

read LINE < ${FILE}
echo ${LINE}
