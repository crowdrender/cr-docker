#! /bin/bash
# by zocker1600 2019 - 2021

download_cr() {
	# check if all ENV variables are set
#	if [ -z "$username" ] || [ -z "$password" ];then
#		echo "you need to specify username and password!"
#		exit 1
#	else
		# download the specified version of the crowdrender addon
		echo "downloading version $CR_VERSION of crowdrender......"
		./download_cr.sh
		
		# install addon into blender
		echo "installing crowdrender addon......."
		/usr/local/blender/blender -b -noaudio --python install_addon.py
		
		# show the installed version of blender for debugging purposes
		echo "blender launch test:"
		/usr/local/blender/blender -b --version
#	fi
}

if [ -z "$machine_uuid" ];
then
	echo "machine_uuid is not set...generating new unique UUID....."
	machine_uuid=$(cat /proc/sys/kernel/random/uuid)
fi

start_server (){
	# activate all GPUs (this is a workaround for a bug)
	echo "activating all available GPUs......"
	/usr/local/blender/blender -b -noaudio --python activate_gpu.py

	# start the CR server
	echo "starting crowdrender server....................."
	/usr/local/blender/blender -b -noaudio --python /root/.config/blender/$BLENDER_VERSION/scripts/addons/crowdrender/src/py_3_7/serv_int_start.py -- -p "$persistent" -ct "$token" -t "server_int_proc" -ak "$machine_uuid"
}


# check if crowdrender addon is already installed
if test -r "$CR_VERSION.zip"; then
	echo ""
	echo ""
	echo ""
	echo "-------------------------------------------------------------"
	echo "crowdrender is already installed"
	start_server
else
	download_cr
	start_server
fi
