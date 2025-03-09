# OpenSSH Client

[![Docker Hub pulls](https://badgen.net/docker/pulls/mountainash/openssh-client)](https://hub.docker.com/r/mountainash/openssh-client) [![GitLab Releases](https://badgen.net/gitlab/release/containeryard/openssh)](https://gitlab.com/containeryard/openssh/-/releases)

> A handy Docker Image for connecting through SSH to remote hosts with _optional_ support for SSH host keys.

![Pufferfish](https://gitlab.com/containeryard/openssh/-/raw/14afda69422ca6c4dc91e49cf79de24f0a65b226/avatar.png)

Can be used in a deployment pipeline to connect to a remote host, and run a git, a Docker `pull` or any CLI command. It's very small and lightweight, based on Alpine Linux.

## Setup

Image available on [Docker Hub](https://hub.docker.com/r/mountainash/openssh-client) or [GitLab Container Registry](https://gitlab.com/containeryard/openssh/container_registry/1422252).

### Environment Variables

These variables are set in the CI/CD settings (these could be any CI/CD pipeline service eg. GitHub Actions, GitLab CI/CD, CircleCI, Jenkins, etc.):
- `SSH_HOST` (remote's hostname)
- `SSH_KNOWN_HOSTS` (host's key signature eg. `[172.31.98.99]:22222 ssh-ed25519 AAAAC3NzaC1lZDI1NTE...n9K9hnplyRGA3MJfe/wBoCVIaX`, can be set to `NoStrictHostKeyChecking` to not check)
- `SSH_PRIVATE_KEY` (SSH private key added to the agent store)

### Tool: Generating SSH_PRIVATE_KEY

Need some new keys? You can use this image to generate them (no polluting up your local machine with keys - and adding to your "vector").

```sh
docker run --rm mountainash/openssh-client:latest ./keygen.sh
```

Four different types (dsa, ecdsa, ed25519, or rsa) public and private authentication keys will be printed to stdout. Pick your perferred key type and copy & paste into your CD/CI settings and remote server.

### Tip: Getting SSH_KNOWN_HOSTS

SSH to the server and run `ssh-keyscan` on the full domain name of the `SSH_HOST`:

```sh
ssh-keyscan hostname.com
```

You can also do it locally, but doing it on the server it's self prevents any man-in-the-middle shenanigans.

### Example: GitLab CI/CD Pipeline

Create a `.gitlab-ci.yml` file in the root of your project to trigger SSH commands on a remote server and commit to the `master` branch (pre-cloning on the server would already be needed).

```yml
deploy:
  ## Suffix with latest with a SHA for better security
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
    - ssh $SSH_USER_NAME@$SSH_HOST "cd /www && git pull $CI_REPOSITORY_URL && exit"
  allow_failure: false
```

### Example: GitHub Actions Workflow

In `./github/workflows/ssh-deploy.yml` (or similar). This will copy a file to a remote server on a push to the `main` branch.

```yml
name: Deploy to Remote Server

on:
  push:
    branches:
      - main

jobs:
  deploy:
    name: Deploy to Remote Server
    runs-on: ubuntu-latest
    container:
      image: mountainash/openssh-client:latest
      env:
        SSH_HOST: ${{ vars.SSH_HOST }}
        SSH_KNOWN_HOSTS: ${{ vars.SSH_KNOWN_HOSTS }}
        SSH_USER_NAME: ${{ vars.SSH_USER_NAME }}
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
      volumes:
          - ./:/app/
    steps:
      - name: Copy HTML to Remote Server
        run: scp /app/sample.html $SSH_USER_NAME@$SSH_HOST:/home/mountainash/www/sitename/index.html
```

## Contribute

- GitLab: <https://gitlab.com/containeryard/openssh>
- GitHub (mirror): <https://github.com/mountainash/openssh-client>

## Credits

- Based on <https://github.com/chuckyblack/docker-openssh-client> / <https://hub.docker.com/r/jaromirpufler/docker-openssh-client> but added host keys support & keygen script
- Pufferfish by [Catalina Montes from the Noun Project](https://thenounproject.com/term/pufferfish/181192/)