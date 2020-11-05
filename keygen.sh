#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

# dsa
(mkfifo key key.pub && cat key key.pub &) ; echo "y" | ssh-keygen -t dsa -C "openssh docker image public dsa key" -f key -q -N "" &>/dev/null ; rm key key.pub

# ecdsa
(mkfifo key key.pub && cat key key.pub &) ; echo "y" | ssh-keygen -t ecdsa -C "openssh docker image public ecdsa key" -f key -q -N "" &>/dev/null ; rm key key.pub

# ed25519
(mkfifo key key.pub && cat key key.pub &) ; echo "y" | ssh-keygen -t ed25519 -C "openssh docker image public ed25519 key" -f key -q -N "" &>/dev/null ; rm key key.pub

# rsa
(mkfifo key key.pub && cat key key.pub &) ; echo "y" | ssh-keygen -t rsa -C "openssh docker image public rsa key" -f key -q -N "" &>/dev/null ; rm key key.pub

exit 0