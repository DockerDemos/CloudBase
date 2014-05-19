#!/bin/bash

PUBKEY="${PUBKEY}"

echo "$PUBKEY" >> /home/clouduser/.ssh/authorized_keys

/usr/sbin/sshd -D
