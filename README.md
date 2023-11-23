# Official CrowdRender-Server docker image w/ GPU support

## Version Table for non Cuda based images

| Docker tag             | Blender version | Default CR_VERSION value | Actual version downloaded         |
|:----------------------:|:---------------:|:------------------------:|:---------------------------------:|
| `bl_4.0`               | `4.0.1`         | `latest`                 | latest available for your [account](https://discovery.crowd-render.com/sign-up) |
| `bl_3.6`               | `3.6.5`  (LTS)  | `latest`                 |                                   |
| `bl_3.5`               | `3.5.1`         | `latest`                 |                                   |
| `bl_3.4`               | `3.4.1`         | `latest`                 |                                   |
| `bl_3.3`               | `3.3.12` (LTS)  | `latest`                 |                                   |


### EOL Tags

- `bl_3.1` *(Blender 3.1)*
- `bl_2.83` *(Blender 2.83 LTS)*

[![Dockerimage builder](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-latest.yml/badge.svg)](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-latest.yml)

## Instructions for normal images (Linux)
These images are based on [debian:stable-slim](https://hub.docker.com/_/debian/tags?page=1&name=stable-slim) and intended for use on linux.
They do install the Nvidia container toolkit and setup for providing GPU acceleration, though our testing with real GPUs is still a work in progress.


## Instructions for running GPU acceleration (nvidia)

In order to make this image work, you need Docker >= 19.03 and the latest [NVIDIA driver](https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#how-do-i-install-the-nvidia-driver)

```bash
docker run -t \
 --name "Crowdrender-Server" \
 -e token=<login_token> \
 --net=host \
 --gpus all #optional for if you want to use gpus
crowdrender/blender-plugin:bl_4.0 #replace the version number with any supported Blender version
```

## Usage


1. Start a container with the image
2. The server should be added to your [cloud account](https://discovery.crowd-render.com/sign-up) and will show up shortly in any session of Blender that has been logged into your account.

- `--name` User friendly name for the image

- `-e token` Mandatory in order to download the addon and for connection to the CR server; `<` and `>` are **not** part of the token!
  _(you can get your token from [here](https://discovery.crowd-render.com/profile))_  
  - `--publish` forwards ports to the OS. Official values are are `9669` - `9714` for the current freely available and latest stable versions of Crowdrender.

  - (IMPORTANT - **Docker Desktop** does NOT work with the `--net=host`, please us the `-p` option instead, for more info see docker documentation [here](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose))

#### Optional Parameters:

- `-e CR_VERSION`: the version string of the CR addon (used for downloading); default: `latest`
- `-e machine_uuid`: if you want to give the container a specific UUID; default is the one from `/proc/sys/kernel/random/uuid`
- `-e secret`: for use where the container is exposed to a public netowrk, you can set a secret which will need to be sent in connection requests, its highly recommended
                to ensure all clients are logged into your cloud account, otherwise connection will not work.
- `-e persistent true|false`: set the container to be reigstered as a persistent node, which will permanently register it to your account.; default: `false`
- `--hostname`: change hostname of the docker container (this is the name that will appear on the CR clients list)

**IMPORTANT:** the latest free CR version is `0.4.5`, ***everything above is only available for supporters of our dev fund, [learn more here](https://www.crowd-render.com/crowdfunding)!***


The CrowdRender documentation can be found [here](https://www.crowd-render.com/learn).

## Version Table

| Docker tag          | Blender version | Default CR_VERSION value | Actual version downloaded              |
|:-------------------:|:---------------:|:--------------------:|:--------------------------------:|
| `bl_4.0-DockerDesktop`       | `4.0.1`         | `latest`                 | latest available for your [account](https://discovery.crowd-render.com/sign-up) |
| `bl_3.6-DockerDesktop`       | `3.6.5`  (LTS)  | `latest`                 |                                   |
| `bl_3.5-DockerDesktop`       | `3.5.1`         | `latest`                 |                                   |
| `bl_3.4-DockerDesktop`       | `3.4.1`         | `latest`                 |                                   |
| `bl_3.3-DockerDesktop`       | `3.3.12` (LTS)  | `latest`                 |                                   |

## Instructions for Cuda based images - intended for Docker Desktop on windows

These images are based on [nvidia/cuda](https://hub.docker.com/r/nvidia/cuda) and have been tested to work on windows using Docker Desktop via WSL2. 

In order to make this work, you need 
- Windows 10 v21H2 (or greater) or windows 11
- Docker Desktop  v2.1 or higher
- Nvidia GPU driver > v[527.41](https://docs.nvidia.com/deploy/cuda-compatibility/#minor-version-compatibility)

```bash
docker run -t \
 --name "Crowdrender-Server" \
 -e token=<your_login_token> \
 --publish 9669-9714:9669-9714
crowdrender/blender-plugin:bl_4.0 #replace the version number with any supported Blender version
```

## Usage

- `--name` User friendly name for the image

- `-e token` Mandatory in order to download the addon and for connection to the CR server; `<` and `>` are **not** part of the token!
  _(you can get your token from [here](https://discovery.crowd-render.com/profile))_  
  - `--publish` forwards ports to the OS. Official values are are `9669` - `9714` for the current freely available and latest stable versions of Crowdrender.

  - (IMPORTANT - **Docker Desktop** does NOT work with the `--net=host`, please us the `-p` option instead, for more info see docker documentation [here](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose))

#### Optional Parameters:

- `-e CR_VERSION`: the version string of the CR addon (used for downloading); default: `latest`
- `-e machine_uuid`: if you want to give the container a specific UUID; default is the one from `/proc/sys/kernel/random/uuid`
- `-e secret`: for use where the container is exposed to a public netowrk, you can set a secret which will need to be sent in connection requests, its highly recommended
                to ensure all clients are logged into your cloud account, otherwise connection will not work.
- `-e persistent true|false`: set the container to be reigstered as a persistent node, which will permanently register it to your account.; default: `false`
- `--hostname`: change hostname of the docker container (this is the name that will appear on the CR clients list)

**IMPORTANT:** the latest free CR version is `0.4.5`, ***everything above is only available for supporters of our dev fund, [learn more here](https://www.crowd-render.com/crowdfunding)!***

## Extra Bits

**if you have any problems or questions, you can create an [issue](https://github.com/crowdrender/cr-docker/issues) or feel free to contact us: `info(at)crowdrender(dot)com(dot)au`**

- [GitHub repo](https://github.com/crowdrender/cr-docker) 
- [Crowdrender website](https://www.crowd-render.com/)
- [DockerHub repo](https://hub.docker.com/r/crowdrender/blender-crowdrender)
