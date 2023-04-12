#!/bin/bash

xhost +
sudo docker run -it --ipc=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v `pwd`:/savedir --privileged rgbd-training:latest
