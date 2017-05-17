#!/bin/bash
make clean TARGET=zoul
make udp-server TARGET=zoul 
sudo make udp-server.upload TARGET=zoul PORT=/dev/ttyUSB$1
make login TARGET=zoul PORT=/dev/ttyUSB$1
