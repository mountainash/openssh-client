#!/bin/sh

set -o pipefail

if [ "$SSH_PRIVATE_KEY" ]; then
    ## Run ssh-agent (inside the build environment)
    eval $(ssh-agent -s)

    ## Add the SSH key stored in SSH_PRIVATE_KEY variable to the agent store
    echo "${SSH_PRIVATE_KEY}" | ssh-add -
fi

if [ "$SSH_KNOWN_HOSTS" == "NoStrictHostKeyChecking" ]; then
    echo "Info: disabling Strict HostKey Checking"

    touch ~/.ssh/config
    echo -e "Host *\n\tStrictHostKeyChecking no\n\n" >> ~/.ssh/config

elif [ "$SSH_KNOWN_HOSTS" ]; then
    echo "Info: adding Known Hosts"

    touch ~/.ssh/known_hosts
    echo "$SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts
    chmod 644 ~/.ssh/known_hosts
fi

exec "$@"