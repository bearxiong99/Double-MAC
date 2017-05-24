#!/bin/bash
SKIP=0
UPLOAD=1
PORT=1

for opt in $@
do
	case "$opt" in
		"k" ) SKIP=1;;
		"l" ) UPLOAD=0;;
		* ) PORT=$opt;;
	esac
done

if [ $UPLOAD -eq 1 ]
then
	if [ $SKIP -eq 0 ]
	then
		sudo make clean TARGET=zoul BOARD=firefly
		sudo make udp-client TARGET=zoul BOARD=firefly
	fi
	sudo make udp-client.upload TARGET=zoul PORT=/dev/ttyUSB$PORT BOARD=firefly
fi
sudo make login TARGET=zoul PORT=/dev/ttyUSB$PORT BOARD=firefly


