#! /bin/bash
# (c) Crowdrender 2019 - 2022

function download_cr {
    if test -z $token; then
        echo "ERROR: you need to specify a login token in order to download the latest version!"
        exit 1
    else 
        echo "download token given with length of ${#token}"
    fi

    # use the token for downloading
    if [ $CR_VERSION == "latest" ]; then
        echo "downloading latest CR version!"
        curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/download/addon/$CR_VERSION -o $CR_VERSION.zip
    else
        echo "downloading CR version: $CR_VERSION!"
        curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/download/addon/$CR_VERSION.zip -o $CR_VERSION.zip
    fi
}

function setup_cr {
    # check if crowdrender addon is already downloaded
    if test -r "/CR/$CR_VERSION.zip"; then
        echo ""
        echo ""
        echo ""
        echo "-------------------------------------------------------------"
        echo "found already existing $CR_VERSION.zip"
    else
        # download the specified version of the crowdrender addon
        echo "downloading version $CR_VERSION of crowdrender......"
        download_cr
    fi

    # install addon into blender
    echo "installing crowdrender addon......."
    /usr/local/blender/blender -b -noaudio --python ./install_addon.py

    # show the installed version of blender for debugging purposes
    echo "Blender launch test:"
    /usr/local/blender/blender -b --version
}

function start_server {
    ROOT_PATH="/root/.config/blender/$BLENDER_VERSION/scripts/addons/crowdrender"

    if test -f "$ROOT_PATH/src/cr/serv_int_start.py"; then
        echo "using workaround for source CR version..."
        BLENDER_PYV="cr"
    fi

    CR_PATH="src/$BLENDER_PYV"

    if test -f "$ROOT_PATH/cr_source/core/serv_int_start.py"; then
        echo "replacing CR_PATH for CR >= 0.4.0..."
        CR_PATH="cr_source/core"
    fi

    if [ $local == "true" ]; then
        echo "starting crowdrender server in LOCAL MODE....................."
        /usr/local/blender/blender -b -noaudio --python $ROOT_PATH/$CR_PATH/serv_int_start.py -- -t "server_int_proc"
    else
        echo "starting crowdrender server in CLOUD MODE....................."
        /usr/local/blender/blender -b -noaudio --python $ROOT_PATH/$CR_PATH/serv_int_start.py -- -p "$persistent" -ct "$token" -t "server_int_proc" -ak "$machine_uuid"
    fi
}

# check if machine_uuid is set
if [ -z "$machine_uuid" ];
then
    echo "machine_uuid is not set...generating new unique UUID....."
    machine_uuid=$(cat /proc/sys/kernel/random/uuid)
fi

setup_cr
start_server
