# v1.1.5
## Features
- Info outputs added to help with debugging workflows (are they adding the key/values correctly?)
- README instructions are less GitLab centric

# v1.1.4
## Features
- Updated GitHub Actions action dependencies
## Fixes
- Logic change to allow `SSH_KNOWN_HOSTS="NoStrictHostKeyChecking"` logic to run

# v1.1.3
## Features
- Added GitHub Actions example to README
## Fixes
- setting USER so `~` substitution works as expected
- Pulled latest `alpine` base image
- "GitHub" branding from "Github"

# v1.1.2
## Features
- Added GitHub Actions to build and push the image to Docker Hub (as it's [a bit of a mess to do 2 pushes in a Gitlab CI](https://gitlab.com/gitlab-org/gitlab/-/issues/277167))

# v1.1.1
## Features
- Added a push mirror from GitLab to GitHub
- Added Gitlab (Trivy) Container Scanning CI stage

# v1.1.0
## Features
- Added Changelog
- Added Readme badges

# v1.0.1
## Fixes
- changed entrypoint to **not** require envars to be set

# v1.0.0
- Initial release