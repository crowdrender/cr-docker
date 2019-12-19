#! /bin/bash
# made by zocker1600 (c) Crowdrender 2019

echo "using token for login...."

# echo token for debugging
echo "your download token is: $token"

# use the token in order to download the latest version of CR
curl -H "Authorization: Bearer $token" -X GET https://discovery.crowd-render.com/api/v0/download-addon/$CR_VERSION.zip -o $CR_VERSION.zip

echo "downloaded $CR_VERSION.zip"
