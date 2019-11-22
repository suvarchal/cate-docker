[![Docker Repository on Quay](https://quay.io/repository/bcdev/cate/status "Docker Repository on Quay")](https://quay.io/repository/bcdev/cate)

# Cate docker base-image

This repository aims at providing a configuration for a docker base image
that can be used to run cate services like `cate-webapi-start`.

## Running cate from a docker container using this image

Cate for docker is currently hosted on quay.io. Hence, use the following
command to run cate:

```shell script
docker run -it quay.io/bcdev/cate bash
```

This will open a bash session with an activated cate Python environment. However,
if you want to make this session a bitmore useful, mount a volume e.g the current directory:

```shell script
docker run -it -v $PWD:/workspace quay.io/bcdev/cate:stage_dzelge_init_cate_docker bash
```

## Release process

cate-docker is hosted on quay.io. quay.io automatically starts a build on every push
that is committed to the [cate-docker repositiry](https://github.com/CCI-Tools/cate-docker).
The version tag of the docker image is set as the name of the branch that has been 
used as a tag.

Therefore, use the following steps to release a new cate docker image:

- Clone or fork [cate-docker repositiry](https://github.com/CCI-Tools/cate-docker.
- Creata a new branch called [your_user_name]_[new_version]
- Make sure that teh cate version exist
- Edit the Dockerfile and change `ARG CATE_VERSION=[new_version]`
- Push the changes to your branch
- Monitor building process on quay.io
- If the build succeeds, create a Pull request and set reviewers
- Once approved merge the PR
- Check again whether the build succeeds. Be aware that from  that moment
  your build will be pulled as version `latest`
- Create a `tag` names `[new_version]`
- Also this version will be built and downloadable as `quay.io/bcdev/cate:[new_version]`


 
