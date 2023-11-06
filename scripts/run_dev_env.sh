#! /bin/bash
# (c) Crowdrender 2019 - 2022

# unpack args
dev_location=$1 # location on host where the crowdrender addon folder is located (ensure you include /crowdrender in the path)
image=$2 # docker tag to use
blender_version=$3 # Blender version without the patch number i.e. MAJOR.MINOR e.g. 3.2
cr_token=$4 # Crowdrender auth token

export BL_VERSION_SHORT=$blender_version
export CR_ADDON_PATH="/root/.config/blender/$blender_version/scripts/addons/crowdrender"


# Error if the dev_location isn't a directory 
if ! [ -d $dev_location ];
then
    echo "Bad! The dev location: $dev_location doesn't exist!"
fi


echo "Using $dev_location for local source, installing into $CR_ADDON_PATH"


docker run -dt --publish 9669-9714:9669-9714 --mount type=bind,source=$dev_location,target=$CR_ADDON_PATH \
    -e token="$cr_token" \
    -e use_local_cr=true \
    $image

echo "Press any key to exit"
read -rn1 # pause the terminal window so we can read any errors, closes instantly without this.