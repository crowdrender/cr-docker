# Official CrowdRender-Server docker image w/ GPU support

### Supported Tags

- `latest` | `bl_3.2` *(Blender 3.2)*
- `bl_2.93` *(Blender 2.93 LTS)*
- `bl_2.83` *(Blender 2.83 LTS)*

[![Dockerimage builder](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-latest.yml/badge.svg)](https://github.com/crowdrender/cr-docker/actions/workflows/dockerimage-latest.yml)

## Instructions (CPU)

```bash
docker run -it \
 --name "Crowdrender-Server" \
 -e token=<login_token> \
 --net=host \
crowdrender/blender-crowdrender:latest
```

Now you should be able add the server to the list of render nodes.

The CrowdRender documentation can be found [here](https://www.crowd-render.com/learn).

## Instructions (Nvidia GPU)

In order to make this work, you need 

- Docker >= 19.03 
- Nvidia GPU driver > 444
- `nvidia-docker2` (an official guide by Nvidia can be found [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html))

```bash
docker run -it \
 --name "Crowdrender-Server" \
 -e token=<login_token> \
 --net=host \
 --gpus all \
crowdrender/blender-crowdrender:latest
```

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

## `CR_VERSION` Table

| CR_VERSION           | Crowdrender version              | Blender version |
|:--------------------:|:--------------------------------:|:---------------:|
| `latest`             | latest available for the account | `2.80 - 3.2`    |
| `cr_044_bl280`       | `0.4.4`                          | `2.80 - 3.2`    |
| `cr_043_bl280`       | `0.4.3`                          | `2.80 - 3.2`    |
| `cr_042_bl280`       | `0.4.2`                          | `2.80 - 3.2`    |
| `cr_041_bl280`       | `0.4.1`                          | `2.80 - 2.93`   |
| `cr_040_bl280`       | `0.4.0`                          | `2.80 - 2.93`   |
| `cr_032_bl280`       | `0.3.2`                          | `2.80 - 2.93`   |
| `cr_031_bl280`       | `0.3.1`                          | `2.80 - 2.93`   |
| `cr_030_bl280`       | `0.3.0`                          | `2.80 - 2.93`   |
| `cr_0210_bl280`      | `0.2.10`                         | `2.80 - 2.93`   |
| `cr_025_bl279`       | `0.2.5`                          | `2.79b`         |
| `cr_024_bl279`       | `0.2.4`                          | `2.79b`         |
| `cr_023_bl280`       | `0.2.3`                          | `2.79b`         |
| `cr_022_bl279`       | `0.2.2`                          | `2.79b`         |
| `cr_021_bl279`       | `0.2.1`                          | `2.79b`         |
| `cr_020_bl279`       | `0.2.0`                          | `2.79b`         |
| `cr_018_bl279`       | `0.1.8`                          | `2.79b`         |
| `cr_017`             | `0.1.7`                          | `2.79b`         |
| `cr_016`             | `0.1.6`                          | `2.79b`         |
| `cr_015`             | `0.1.5`                          | `2.79b`         |
| `cr_014_bl279_Patch` | `0.1.4`                          | `2.79b`         |

**IMPORTANT:** the latest free CR version is `0.4.1`, ***everything above is only available for supporters of our dev fund, [learn more here](https://www.crowd-render.com/crowdfunding)!***

## Extra Bits

**if you have any problems or questions, you can create an [issue](https://github.com/crowdrender/cr-docker/issues) or feel free to contact us: `info(at)crowdrender(dot)com(dot)au`**

- [GitHub repo](https://github.com/crowdrender/cr-docker) 
- [Crowdrender website](https://www.crowd-render.com/) 
- [DockerHub repo](https://hub.docker.com/r/crowdrender/blender-crowdrender)
