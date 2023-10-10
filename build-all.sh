#!/bin/bash

echo "Building all the Docker images"
echo "make sure you have Docker installed"
echo "you have to run this script as sudo user"
echo "see here for more details:"
echo "https://github.com/makiras/verification"
echo ""
echo "starting the build process..."

REPO="makiras/verification"

docker build -t $REPO:sx-synopsys-focal -f ./dockerfiles/sx-synopsys-focal .


echo "build process is finished"
echo -e "exiting"