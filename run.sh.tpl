#!/bin/bash

# Maps HTTP server 8888 to 80 externally
# Makes work directory appear in /project
wd=$(pwd)
docker rm -f pythondevbox
docker run \
--name pythondevbox \
-p 82:8888 \
-v $wd/git/.gitconfig:/root/.gitconfig \
-v $wd/gnupg:/root/.gnupg \
-v $wd/ssh:/root/.ssh \
-v ~/Stuff:/project \
-ti \
chrisramsay/docker-python-devel \
/bin/bash
