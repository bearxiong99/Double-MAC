#!/bin/bash
<<<<<<< HEAD

SKIP=0
UPLOAD=1
PORT=0

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
		sudo make clean TARGET=zoul
		sudo make udp-server TARGET=zoul BOARD=firefly
	fi
	sudo make udp-server.upload TARGET=zoul PORT=/dev/ttyUSB$PORT
fi
sudo make login TARGET=zoul PORT=/dev/ttyUSB$PORT
=======
make clean TARGET=zoul
make udp-server TARGET=zoul 
sudo make udp-server.upload TARGET=zoul PORT=/dev/ttyUSB$1
make login TARGET=zoul PORT=/dev/ttyUSB$1
>>>>>>> cfb03c94646757ad1c576f05b2f24233ab58bb1d
