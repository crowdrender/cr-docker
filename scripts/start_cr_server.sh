#! /bin/bash
# (c) Crowdrender 2019 - 2022

BLENDER_ADDONS_PATH=/root/.config/blender/$BL_VERSION_SHORT/scripts/addons
TRUE=true
FALSE=false

function download_cr {


    # If no token is provided and the user wishes to download the install package...
    if [ -z $token ]; then

        # Signal an error, its not possible to download without auth.
        echo "ERROR: you need to specify a login token in order to download the latest version!"
        exit 1
    
    else
        echo "About to download the $cr_version version of the addon."

        # ... use the token for downloading the addon package useing the dedicated 'latest' URL
        curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/download/addon/$cr_version -o $cr_version.zip

    fi
}


function setup_cr {
    
    # check to see if the local dev path is set, don't install the
    # addon from discovery if so
    if [ $use_local_cr = $TRUE ];
    then
        
        # make sure the script path is set, its not going to be referenced by Blender unless the path is added
        # if we're using the source code for the addon on the host, then we need to setup the script paths properly
        add_script_location="import bpy
bpy.ops.preferences.script_directory_add(directory=\"$BLENDER_ADDONS_PATH\")
bpy.ops.wm.save_userpref()"

        echo " executing $add_script_location"

        /usr/local/blender/blender -b -noaudio --python-expr "$add_script_location" #blender needs a restart after adding a script location.
        /usr/local/blender/blender -b -noaudio --python ./install_addon.py
    
    # check if crowdrender addon is already downloaded
    elif test -r "/CR/$cr_version.zip"; then
        echo ""
        echo ""
        echo ""
        echo "-------------------------------------------------------------"
        echo "found already existing $cr_version.zip"
        # install addon into blender
        echo "installing crowdrender addon......."
        /usr/local/blender/blender -b -noaudio --python ./install_addon.py -i "/CR/$cr_version.zip"

    else

        download_cr

        echo "installing crowdrender addon from /CR/$cr_version.zip"
        /usr/local/blender/blender -b -noaudio --python ./install_addon.py -i "/CR/$cr_version.zip"
    fi

    
    # show the installed version of blender for debugging purposes
    echo "Blender launch test:"
    /usr/local/blender/blender -b --version
}

function start_server {

    CR_ADDON_ROOT="$BLENDER_ADDONS_PATH/crowdrender"

    if test -d $CR_ADDON_ROOT; then
        echo "Crowdrender found at $CR_ADDON_ROOT"
    else
        echo "OOPS! Couldn't find Crowdrender at $CR_ADDON_ROOT"
    fi

    # test if the path to the addon actually exists. 
    if test -f "$CR_ADDON_ROOT/cr_source/core/serv_int_start.py"; then
        START_PY_FILE="$CR_ADDON_ROOT/cr_source/core/serv_int_start.py"
    elif test -f "$CR_ADDON_ROOT/cr_core/serv_int_start.py"; then
        START_PY_FILE="$CR_ADDON_ROOT/cr_core/serv_int_start.py"
    else
        echo "The path for Crowdrender's scripts was not found, tried using $CR_ADDON_ROOT"
        echo "doing an ls -al on the selected location for the root path"
        echo "user is"
        whoami
        cd "/root/.config/blender/$BL_VERSION_SHORT"
        ls -al
    fi

    # check if there's a blender_process script, if so use this instead of the other method of starting the addon.
    if test -f "$CR_ADDON_ROOT/bootstrap/blender_process.py"; then
        /usr/local/blender/blender \
        -b \
        -noaudio \
        --python "$CR_ADDON_ROOT/bootstrap/blender_process.py"\
        -- \
        --addon-dir "$CR_ADDON_ROOT" \
        --type server_interface \
        -p "$persistent" \
        -ct "$token" \
        --override-machine-uuid "$machine_uuid" \
        -ak "$secret"

    fi 

    # start blender with the proper arguments to start a headless server	
    echo "starting crowdrender server using version $cr_version ..."
    echo "Running script to start server $START_PY_FILE"
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