#! /bin/bash
# (c) Crowdrender 2019 - 2022

function download_cr {


    # exit early if a docker bind mount is specified, but no version number is provided.
    if [ -z "$local_cr_path" ] && [ -z "$cr_version" ]; then
        echo "ERROR: specifying local_cr_path requires you to also specify the version by setting the cr_version option."
        exit 1

    # if the token is not provided and neither has a local bind mount, then exit early.
    elif [ -z "$local_cr_path" ] && [ -z $token ]; then

        echo "ERROR: you need to specify a login token in order to download the latest version!"
        exit 1

    fi

    if [ -z "$cr_version" ]; then
        echo "No specific version set, defaulting to 'latest'."
        cr_version="latest"
    fi

    # if the user provides a local path 
    if ! [ -z "$local_cr_path" ]; then
        
        # use the provided path as the source of the addon package instead of downloading it
        echo "Going to use $local_cr_path as the source of the addon package."

    # alternatively, if the request version is the latest one...
    elif [ $cr_version == "latest" ]; then

        # use the token for downloading the addon package useing the dedicated 'latest' URL
        echo "downloading latest CR version!"
        curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/download/addon/$cr_version -o $cr_version.zip
    
    # otherwise, use the provided version number.
    else
        # 
        echo "downloading CR version: $cr_version!"
        curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/download/addon/$cr_version.zip -o $cr_version.zip
    fi
}

function setup_cr {
    
    # check to see if the local dev path is set, don't install the
    # addon from discovery if so
    if ! [ -z "$local_cr_path" ];
    then
        echo "using mounted location for CR addon"
        /usr/local/blender/blender -b -noaudio --python ./install_addon.py -- -e
    
    # check if crowdrender addon is already downloaded
    elif test -r "/CR/$cr_version.zip"; then
        echo ""
        echo ""
        echo ""
        echo "-------------------------------------------------------------"
        echo "found already existing $cr_version.zip"
        # install addon into blender
        echo "installing crowdrender addon......."
        /usr/local/blender/blender -b -noaudio --python ./install_addon.py -- -i -f "/CR/$cr_version.zip"

    else
        # download the specified version of the crowdrender addon
        echo "downloading version $cr_version of crowdrender......"
        download_cr

        echo "installing crowdrender addon......."
        /usr/local/blender/blender -b -noaudio --python ./install_addon.py -- -i -f "/CR/$cr_version.zip"
    fi

    
    # show the installed version of blender for debugging purposes
    echo "Blender launch test:"
    /usr/local/blender/blender -b --version
}

function start_server {
    ROOT_PATH="/root/.config/blender/$BL_VERSION_SHORT/scripts/addons/crowdrender"

    # test if the path to the addon actually exists. 
    if test -f "$ROOT_PATH/cr_source/core/serv_int_start.py"; then
        START_PY_FILE="$ROOT_PATH/cr_source/core/serv_int_start.py"
    fi

    # start blender with the proper arguments to start a headless server	
    echo "starting crowdrender server using version $cr_version ..."
    /usr/local/blender/blender -b -noaudio --python $START_PY_FILE -- -t "server_int_proc" -p "$persistent" -ct "$token" --override-machine-uuid "$machine_uuid" -ak "$secret"
    
}

# check if machine_uuid is set, if it isn't set it to the value of a random uuid
if [ -z "$machine_uuid" ];
then
    echo "machine_uuid is not set...generating new unique UUID....."
    machine_uuid=$(cat /proc/sys/kernel/random/uuid)
fi

# check to see if the secret has been set by the user, generate one if it hasn't
if [ -z "$secret" ];
then
    echo "secret not given, generating one..."
    secret=$(cat /proc/sys/kernel/random/uuid)
fi

if [ -z "$persistent" ];
then
    echo "Using the default value of persistent: false"
    persistent=false
fi


setup_cr
start_server