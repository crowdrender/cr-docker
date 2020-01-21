# official CrowdRender-Server docker image


### supported tags

- `bl_2.81`, `latest` *(Blender 2.81a)*
- `bl_2.79` *(Blender 2.79)*


## Instructions

Installation instructions for docker itself can be found [here](https://docs.docker.com/install/linux/docker-ce/debian/) or you can use [this](https://get.docker.com/) this installation script for quick & easy install.

To start the docker image run:

```
docker run -t \
 --name "Crowdrender-Server" \
 --token=<login_token> \
 --net=host \
zocker160/blender-crowdrender:latest
```

Now you should be able add the server to the list of render nodes.

The CrowdRender documentation can be found [here](https://www.crowd-render.com/learn).


## Usage

- `--name` here you can set the name of the docker image
- `--token` this is mandatory in order to download the lastest CR version and for the connection to the CR server
_(you can get a token from [here](https://discovery.crowd-render.com/profile))_
- `--net=host` this sets the image to run in the `host`-network

#### optional parameters:

- `-e CR_VERSION=<cr_version>`

**(the default value is always the latest version of CrowdRender)**


## Version table

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

## Extra bits

**if you have any problems or questions, you can create an [issue](https://github.com/crowdrender/cr-docker/issues) or feel free to contact us: info(at)crowdrender(dot)com(dot)au**


[Crowdrender website](https://www.crowd-render.com/) 