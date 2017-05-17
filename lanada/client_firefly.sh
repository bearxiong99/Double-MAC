#!/bin/bash
make clean TARGET=zoul
make udp-client TARGET=zoul 
sudo make udp-client.upload TARGET=zoul PORT=/dev/ttyUSB$1
sudo make login TARGET=zoul PORT=/dev/ttyUSB$1
