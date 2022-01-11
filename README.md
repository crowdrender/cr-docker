# Official CrowdRender-Server docker image w/ GPU support

[GitHub repo](https://github.com/crowdrender/cr-docker) 

### Most Important Tags

- `bl_2.93`, `latest`, `nvidia` *(Blender 2.93 LTS)*
- `bl_2.79`, `bl_2.79_cu_10.1` *(Blender 2.79b)*
- `beta`, `nvidia-beta` *(Blender 3.0)*

[![Dockerimage beta](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-beta.yml/badge.svg)](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-beta.yml)
[![Dockerimage latest](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-latest.yml/badge.svg)](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-latest.yml)

## Instructions for CPU

Installation instructions for docker itself can be found [here](https://docs.docker.com/engine/install/debian/) or you can use [this](https://get.docker.com/) installation script for quick & easy install.

To start the docker image run:

```bash
docker run -t \
 --name "Crowdrender-Server" \
 -e token=<login_token> \
 --net=host \
zocker160/blender-crowdrender:latest
```

Now you should be able add the server to the list of render nodes.

The CrowdRender documentation can be found [here](https://www.crowd-render.com/learn).

## Usage

- `--name` here you can set the name of the docker image

- `-e token` this is mandatory in order to download the lastest CR version and for the connection to the CR server; `<`and `>` are **not** part of the token!
  _(you can get a token from [here](https://discovery.crowd-render.com/profile))_

- `--net=host` this sets the image to run in the `host`-network and allows the application to open the ports on its own 
  
  - (alternatively you can forward the default ports with the `-p` option instead of `--net=host`, ports are `9000`-`9025` for CR < `0.2.8`, `9669` - `9694` for `0.2.8` and beyond)
  - (IMPORTANT - **Docker Desktop** does NOT work if you use `--net=host`, please us the `-p` option instead, for more info see docker documentation [here](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose))

#### Optional Parameters:

- `-e CR_VERSION`: the version string of the CR addon (used for downloading); default: `latest`
- `-e local true|false`: enable LOCAL rendering mode (if you want to render in a local network); default: `false`
- `-e machine_uuid`: if you want to give the container a specific UUID; default is the one from `/proc/sys/kernel/random/uuid`
- `-e persistent true|false`: set the container to be reigstered as a persistent node; default: `false`
- `--hostname`: change hostname of the docker container (this is the name that will appear on the CR clients list)

**IMPORTANT:** the latest free CR version is `0.3.0`, ***everything above is only available for supporters of our dev fund, [learn more here](https://www.crowd-render.com/crowdfunding)!***

## Version Table

| Docker tag          | Blender version | CR_VERSION           | CrowdRender version              |
|:-------------------:|:---------------:|:--------------------:|:--------------------------------:|
| `beta`              | `3.0`           | `latest`             | latest available for the account |
| `bl_2.93`, `latest` | `2.93 LTS`      | `latest`             | latest available for the account |
| `bl_2.83`           | `2.83 LTS`      | `latest`             | latest available for the account |
|                     |                 | `cr_030_bl280`       | `0.3.0`                          |
|                     |                 | `cr_0210_bl280`      | `0.2.10`                         |
| `bl_2.79`           | `2.79b`         | `cr_025_bl279`       | `0.2.5`                          |
|                     |                 | `cr_024_bl279`       | `0.2.4`                          |
|                     |                 | `cr_023_bl280`       | `0.2.3`                          |
|                     |                 | `cr_022_bl279`       | `0.2.2`                          |
|                     |                 | `cr_021_bl279`       | `0.2.1`                          |
|                     |                 | `cr_020_bl279`       | `0.2.0`                          |
|                     |                 | `cr_018_bl279`       | `0.1.8`                          |
|                     |                 | `cr_017`             | `0.1.7`                          |
|                     |                 | `cr_016`             | `0.1.6`                          |
|                     |                 | `cr_015`             | `0.1.5`                          |
|                     |                 | `cr_014_bl279_Patch` | `0.1.4`                          |

## Instructions for GPU (nvidia)

In order to make this image work, you need Docker >= 19.03 and the latest [NVIDIA driver](https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#how-do-i-install-the-nvidia-driver) and `nvidia-docker2` installed on your host system.

An official guide by Nvidia can be found [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian).

**IMPORTANT:** the latest free CR version is `0.3.0`, ***everything above is only available for supporters of our dev fund, [learn more here](https://www.crowd-render.com/crowdfunding)!***

### Version Table

| Docker tag                | Blender  | CUDA |
|:-------------------------:|:--------:|:----:|
| `nvidia-beta`             | 2.93 LTS | 11.0 |
| `bl_2.93_cu_11`, `nvidia` | 2.93 LTS | 11.0 |
| `bl_2.83_cu_11`           | 2.83 LTS | 11.0 |
| `bl_2.83_cu_10`           | 2.83 LTS | 10.2 |
| `bl_2.79_cu_10.1`         | 2.79b    | 10.1 |
| `bl_2.79_cu_9.2`          | 2.79b    | 9.2  |

## Instructions

To start the docker image run:

```bash
docker run -t \
 --name "Crowdrender-Server" \
 --net=host \
 -e token=<login_token> \
 --gpus all \
zocker160/blender-crowdrender:nvidia
```

Now you should be able add the server to the list of render nodes.

The CrowdRender documentation can be found [here](https://www.crowd-render.com/documentation-v016).

#### Usage

- `--name` here you can set the name of the docker image

- `-e token` this is mandatory in order to download the lastest CR version and for the connection to the CR server; `<`and `>` are **not** part of the token! 
  
  *(you can get a token from [here](https://discovery.crowd-render.com/profile))*

- `--net=host` this sets the image to run in the `host`-network and allows the application to open the ports on its own
  
  - (alternatively you can forward the default ports with the `-p` option instead of `--net=host`, ports are `9000`-`9025` for CR < `0.2.8`, `9669` - `9694` for `0.2.8` and beyond)
  - (IMPORTANT - **Docker Desktop** does NOT work if you use `--net=host`, please us the `-p` option instead, for more info see docker documentation [here](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose))

- `--gpus all` this enables the passthrough to the GPU(s)

#### Optional Parameters:

- `-e CR_VERSION`: the version string of the CR addon (used for downloading); default: `latest`
- `-e local true|false`: enable LOCAL rendering mode (if you want to render in a local network); default: `false`
- `-e machine_uuid`: if you want to give the container a specific UUID; default is the one from `/proc/sys/kernel/random/uuid`
- `-e persistent true|false`: set the container to be reigstered as a persistent node; default: `false`
- `--hostname`: change hostname of the docker container (this is the name that will appear on the CR clients list)

## Extra Bits

**if you have any problems or questions, you can create an [issue](https://github.com/crowdrender/cr-docker/issues) or feel free to contact us: info(at)crowdrender(dot)com(dot)au**

[DockerHub repo](https://hub.docker.com/r/zocker160/blender-crowdrender) 
[Crowdrender website](https://www.crowd-render.com/) 
