#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd $SCRIPTPATH/..

version=`grep -oP '(?<=version = ")[^"]+' pyproject.toml | head -n 1`
name=`grep -oP '(?<=name = ")[^"]+' pyproject.toml | head -n 1`

docker build \
	-t ghcr.io/ad-sdl/${name}:${version} \
	-t ghcr.io/ad-sdl/${name}:dev \
	.

