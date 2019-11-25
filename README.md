[![Docker Repository on Quay](https://quay.io/repository/bcdev/cate/status "Docker Repository on Quay")](https://quay.io/repository/bcdev/cate)

# Cate docker base-image

This repository aims at providing a configuration for a docker base image
that can be used to run cate services like `cate-webapi-start`.

## Running cate from a docker container using this image

Cate for docker is currently hosted on quay.io. Hence, use the following
command in order to run cate:

```shell script
docker run -it quay.io/bcdev/cate bash
```

This will open a bash session with an activated cate Python environment. However,
if you want to make this session a bitmore useful, mount a volume e.g the current directory:

```shell script
docker run -it -v $PWD:/workspace quay.io/bcdev/cate bash
```

The following docker-compose configuration can be used to run cate, here, its web service.
 

```yaml
version: "3.7"
services:
  cate:
    image: quay.io/bcdev/cate
    user: cate
    expose:
      - 4000
    ports:
      - 4000:4000
    command: ["/bin/bash", "-c", "source activate cate-env && cate-webapi-start -v -p 4000 -a 0.0.0.0"] 
```


## Release process

cate-docker is hosted on quay.io. quay.io is configured so it automatically starts building processes on each 
push to [cate-dcker's GitHub](https://github.com/CCI-Tools/cate-docker). The docker image version 
tag is set by the name of the branch which includes version and release tags. 

Therefore, use the following steps to release a new cate docker image:

- Clone or fork [cate-docker repositiry](https://github.com/CCI-Tools/cate-docker.
- Creata a new branch called [your_user_name]_[new_version]
- Make sure that the cate version you are building for has been released
- Edit the Dockerfile and change `ARG CATE_VERSION=[new_version]` reflecting the new version tag
- Push the changes to your branch
- Monitor building process on that has been started on quay.io 
- If the build succeeds, create a pull request and request reviewers
- Once approved merge the PR
- Check again whether the build succeeds. Be aware that from that moment
  your the version `latest` will be updated
- Create a `tag` named `[new_version]` in GitHub
- Also this version will be built and be downloadable as `quay.io/bcdev/cate:[new_version]`


 
