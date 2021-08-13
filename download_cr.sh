#! /bin/bash
# made by zocker1600 (c) Crowdrender 2019 - 2021

echo "using token for login...."
    
# echo token status
if test -z $token; then
	echo "ERROR: you need to specify a login token in order to download the latest version!"
	exit 1
else 
    echo "download token given with length of ${#token}"
fi

# use the token in order to download the latest version of CR
if [ $CR_VERSION == "latest" ]; then
	echo "downloading latest CR version!"
	curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/v0/download-addon/$CR_VERSION -o $CR_VERSION.zip
else
	echo "downloading CR version: $CR_VERSION!"
	curl -# -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/v0/download-addon/$CR_VERSION.zip -o $CR_VERSION.zip
fi
