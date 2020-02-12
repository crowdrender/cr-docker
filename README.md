# Official CrowdRender-Server docker image w/ GPU support
[GitHub repo](https://github.com/crowdrender/cr-docker) 

### Most Important Tags

- `bl_2.81`, `latest`, `nvidia` *(Blender 2.81a)*
- `bl_2.79`, `bl_2.79_cu_10.1` *(Blender 2.79)*


## Instructions for CPU

Installation instructions for docker itself can be found [here](https://docs.docker.com/install/linux/docker-ce/debian/) or you can use [this](https://get.docker.com/) this installation script for quick & easy install.

To start the docker image run:

```
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
- `-e token` this is mandatory in order to download the lastest CR version and for the connection to the CR server
_(you can get a token from [here](https://discovery.crowd-render.com/profile))_
- `--net=host` this sets the image to run in the `host`-network

#### Optional Parameters:

- `-e CR_VERSION=<cr_version>`

**(the default value is always the latest version of CrowdRender)**


## Version Table

| Docker tag | Blender version | CR_VERSION | CrowdRender version |
| :---: | :---: | :---: | :---: |
| `bl_2.81`, `latest` | `2.81a` | `cr_022_bl280` | `0.2.2` |
||| `cr_021_bl280` | `0.2.1` |
||| `cr_020_bl280` | `0.2.0` |
||| `cr_018_bl280` | `0.1.8` |
||| `cr_017_bl280` | `0.1.7` |
||| `cr_016_bl280` | `0.1.6` |
||| `cr_016_bl280_b` | `0.1.6b` |
||| `cr_016_bl280_c` | `0.1.6c` |
|`bl_2.79` | `2.79b` | `cr_022_bl279` | `0.2.2` |
||| `cr_021_bl279` | `0.2.1` |
||| `cr_020_bl279` | `0.2.0` |
||| `cr_018_bl279` | `0.1.8` |
||| `cr_017` | `0.1.7` |
||| `cr_016` | `0.1.6` |
||| `cr_015` | `0.1.5` |
||| `cr_014_bl279_Patch` | `0.1.4` |

## Instructions for GPU (nvidia)

In order to make this image work, you need Docker >= 19.03 and the latest [NVIDIA driver](https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#how-do-i-install-the-nvidia-driver) NVIDIA driver installed on your host system.

You also need to have the [nvidia-container-toolkit](https://github.com/NVIDIA/nvidia-docker#ubuntu-16041804-debian-jessiestretchbuster) installed.

### Version Table

| Docker tag | Blender | CUDA |
| :--------------: | :---------: | :-------: |
| `bl_2.81_cu_10`, `nvidia` | 2.81a | 10.2 |
| `bl_2.79_cu_10.1` | 2.79b | 10.1 |
| `bl_2.79_cu_9.2` | 2.79b | 9.2 | 
| `bl_2.79_cu_7.5` | 2.79b | 7.5 |


## Instructions

To start the docker image run:

```
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
- `--net=host` this sets the image to run in the `host`-network (alternatively you could forward the default ports `9000`-`9010`)
- `--runtime=nvidia` this enables the passthrough to the GPU(s)

## Extra Bits

**if you have any problems or questions, you can create an [issue](https://github.com/crowdrender/cr-docker/issues) or feel free to contact us: info(at)crowdrender(dot)com(dot)au**

[DockerHub repo](https://hub.docker.com/r/zocker160/blender-crowdrender) 
[Crowdrender website](https://www.crowd-render.com/) 