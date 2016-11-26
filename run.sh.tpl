#!/bin/bash

###
# Add more mounts for your projects after the git/gnupg/ssh ones
# e.g. -v ~/stuff/myproject:/project \

wd=$(pwd)
img=docker-python
if docker ps | grep $img | awk '{ print $11 }'
    then
    com=$(docker rm -f $img)
    echo "Removed ${com}"
fi
docker run \
--name $img \
-p 82:8888 \
-v $wd/git/.gitconfig:/root/.gitconfig \
-v $wd/gnupg:/root/.gnupg \
-v $wd/ssh:/root/.ssh \
-v ~/stuff/myproject:/project \
-ti \
chrisramsay/$img:latest \
/bin/bash
