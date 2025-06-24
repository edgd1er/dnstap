#!/usr/bin/env bash

#create /var/log if missing
[[ ! -d /var/log/ ]] && mkdir -p /var/log/dnstap/ || true

/bin/dnstap -l ${TAPADDRESS}:${TAPPORT} -${TAPFORMAT} -w ${TAPFILE}