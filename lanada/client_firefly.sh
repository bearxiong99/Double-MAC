#!/bin/bash
make clean TARGET=zoul
make udp-client TARGET=zoul BOARD=firefly
make udp-client.upload TARGET=zoul PORT=/dev/ttyUSB1
make login TARGET=zoul PORT=/dev/ttyUSB1
