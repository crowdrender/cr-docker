#! /bin/bash
# by zocker1600 2019 - 2021

setup_cr() {
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
		./download_cr.sh
	fi
	
	# install addon into blender
	echo "installing crowdrender addon......."
	/usr/local/blender/blender -b -noaudio --python ./install_addon.py
	
	# show the installed version of blender for debugging purposes
	echo "blender launch test:"
	/usr/local/blender/blender -b --version
}

start_server() {
	# start the CR server
	if [ $usegpu == "true" ]; then
		# activate all GPUs (this is a workaround for a bug)
		echo "activating all available GPUs......"
		/usr/local/blender/blender -b -noaudio --python activate_gpu.py
	else
		echo "INFO: running in CPU only mode!"
	fi
	
	if [ $local == "true" ]; then
		echo "starting crowdrender server in LOCAL MODE....................."
		/usr/local/blender/blender -b -noaudio --python /root/.config/blender/$BLENDER_VERSION/scripts/addons/crowdrender/src/py_3_7/serv_int_start.py -- -t "server_int_proc"
	else
		echo "starting crowdrender server in CLOUD MODE....................."
		/usr/local/blender/blender -b -noaudio --python /root/.config/blender/$BLENDER_VERSION/scripts/addons/crowdrender/src/py_3_7/serv_int_start.py -- -p "$persistent" -ct "$token" -t "server_int_proc" -ak "$machine_uuid"
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
