#! /bin/bash
# (c) Crowdrender 2019 - 2022

# unpack args
dev_location=$1 # location on host where the crowdrender addon folder is located (ensure you include /crowdrender in the path)
docker_tag=$2 # docker tag to use
blender_version=$3 # Blender version without the patch number i.e. MAJOR.MINOR e.g. 3.2
cr_token=$4 # Crowdrender auth token

export BL_VERSION_SHORT=$blender_version


# Error if the dev_location isn't a directory 
if ! [ -d $dev_location ];
then
    echo "Bad! The dev location: $dev_location doesn't exist!"
fi

# Set a blank tag if not specified
if [ -z "$docker_tag" ];
then
    
    image=cr
else
    image="cr:$docker_tag"
fi
echo "Using $docker_tag tag'"


docker run -dt --name "Crowdwrender-Server-DEV" -e token="$cr_token" --publish 9669-9694:9669-9694 --mount type=bind,source=$dev_location,destination="/root/.config/blender/$BL_VERSION_SHORT/scripts/addons/crowdrender" $image 