#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset


if [ ! -z "$SSH_PRIVATE_KEY" ]; then
    ## Run ssh-agent (inside the build environment)
    eval $(ssh-agent -s)

    ## Add the SSH key stored in SSH_PRIVATE_KEY variable to the agent store
    echo "${SSH_PRIVATE_KEY}" | ssh-add -
fi

if [ ! -z "$SSH_KNOWN_HOSTS" ]; then
    echo "$SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts
    chmod 644 ~/.ssh/known_hosts
fi

if [ "$SSH_KNOWN_HOSTS" == "NoStrictHostKeyChecking" ]; then
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" >> ~/.ssh/config
fi

exec "$@"