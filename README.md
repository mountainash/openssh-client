# OpenSSH Client

[![Docker Hub pulls](https://badgen.net/docker/pulls/mountainash/openssh-client)](https://hub.docker.com/r/mountainash/openssh-client) [![GitLab Releases](https://badgen.net/gitlab/release/containeryard/openssh)](https://gitlab.com/containeryard/openssh/-/releases)

> A handy Docker Image for connecting through SSH to remote hosts with _optional_ support for SSH host keys.

![Pufferfish](https://gitlab.com/containeryard/openssh/-/raw/14afda69422ca6c4dc91e49cf79de24f0a65b226/avatar.png)

Can be used in a deployment pipeline to connect to a remote host, and run a git, a Docker `pull` or any CLI command.

## Setup
### Environment Variables

These variables are set in GitLab CI/CD settings (but could be any CI/CD pipeline service [eg. Github Actions, Jenkins, etc.]):
- `SSH_HOST` (remote's hostname)
- `SSH_KNOWN_HOSTS` (host's key signature, can be set to `NoStrictHostKeyChecking` to not check)
- `SSH_USER_NAME` (ssh username for access to the host)
- `SSH_PRIVATE_KEY` (ssh private key for SSH_USER_NAME)

### Generating SSH_PRIVATE_KEY

Need some new keys? You can use this image to generate them (no polluting up your local machine with keys - and adding to your "vector").

```sh
docker run --rm mountainash/openssh-client:latest ./keygen.sh
```

Four different types (dsa, ecdsa, ed25519, or rsa) public and private authentication keys will be printed to stdout. Pick your perferred key type and copy & paste into your CD/CI settings and remote server.

### Getting SSH_KNOWN_HOSTS

SSH to the server and run `ssh-keyscan` on the full domain name of the `SSH_HOST`:

```sh
ssh-keyscan hostname.com
```

You can also do it locally, but doing it on the server it's self prevents any man-in-the-middle shenanigans.

### GitLab CI/CD Example

Create a `.gitlab-ci.yml` file in the root of your project to trigger SSH commands on a remote server on commit to the `master` branch.

```yml
deploy:
  image: mountainash/openssh-client:latest
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

`image` can also be pulled from `registry.gitlab.com/containeryard/openssh`

## Contribute

- GitLab: <https://gitlab.com/containeryard/openssh>
- GitHub (mirror): <https://github.com/mountainash/openssh-client>

## Credits

- Based on <https://github.com/chuckyblack/docker-openssh-client> / <https://hub.docker.com/r/jaromirpufler/docker-openssh-client> but added host keys support
- Pufferfish by [Catalina Montes from the Noun Project](https://thenounproject.com/term/pufferfish/181192/)