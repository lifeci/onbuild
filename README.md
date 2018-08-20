# onbuild
_CircleCi status(s) per branch_: master: [![CircleCI](https://circleci.com/gh/lifeci/onbuild/tree/master.svg?style=svg&circle-token=557f30802090af8463e309bd664ae03c67a528fd)](https://circleci.com/gh/lifeci/onbuild/tree/master)

## Description
- Public source and container image repo
- Stateles containers with pre-installed tools
- Default OS: Linux.  If required feel free to contribute changes for Windows/MacOs platform

## Reason(s)
- building/spinup ci/cd pipelines

## ImageRepo
- Usage: `docker run lifeci/onbuild:aws15 aws --version`
- Link to DockerHub: https://hub.docker.com/r/lifeci/onbuild/tags/
- Tags: https://hub.docker.com/r/lifeci/onbuild/tags/

## ToDo
 - [ ] Add initial behavior like: if Parameter1 exist do login
 - [ ] Data persistent via mapped volumes
 - [ ] Set CMD and entrypoint per tool(s).
 - [ ] Prepare main PID 1 to accept triggers related to the tool
 - [ ] Build containers separate by tooling
 - [ ] Make sets based on usage: CI/CD tools, CloudCLIs, IaC tools, etc
 
 ## License
 Opensource
