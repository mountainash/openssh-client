# openssh-client

A handy Docker Image for connecting through SSH to remote hosts.

## Gitlab CI/CD Example

```yml
# These variables are set in GitLab CI/CD variables
# - SSH_HOST (remote's hostname)
# - SSH_KNOWN_HOSTS (host's key signature)
# - SSH_USER_NAME (ssh username for access to the host)
# - SSH_PRIVATE_KEY (ssh key for SSH_USER_NAME)

deploy:
  image: registry.gitlab.com/containeryard/openssh
  only:
    - master
  environment:
    name: production
    url: https://domainname.com/
  variables:
    GIT_STRATEGY: none
    GIT_SUBMODULE_STRATEGY: none
  script:
    - ssh $SSH_USER_NAME@$SSH_HOST "cd /www && git pull origin master && exit"
  allow_failure: false
```

## Docker Compose Example

```yml
version: '3'

services:
  openssh:
    image: registry.gitlab.com/containeryard/openssh
    environment:
      SSH_HOST: hostname.com
      SSH_USER_NAME: gitlab-cicd
      SSH_PRIVATE_KEY: |-
        -----BEGIN RSA PRIVATE KEY-----
          ...
        -----END RSA PRIVATE KEY-----
      SSH_KNOWN_HOSTS: hostname.com ssh-ed25519 AAAAC3Nz...Ygns # can be set to `NoStrictHostKeyChecking`
    command: ls
```

Most of these will be set in the CI Environment if running on Gitlab.

## Getting SSH_KNOWN_HOSTS

SSH to the server and run `ssh-keyscan` on the full domain name of the `SSH_HOST`:

```sh
ssh-keyscan tigh.asoshared.com
```

## Credits

Based on https://github.com/chuckyblack/docker-openssh-client / https://hub.docker.com/r/jaromirpufler/docker-openssh-client