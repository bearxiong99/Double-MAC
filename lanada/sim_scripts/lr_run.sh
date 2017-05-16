#!/bin/bash

CONTIKI=/media/user/Harddisk/Double-MAC/

echo "Long range simulation"
sed -i 's/\#define DUAL_RADIO 0/\#define DUAL_RADIO 1/g' $CONTIKI/platform/cooja/contiki-conf.h

topology=$1
TRAFFIC_MODEL=$2
PERIOD=$3
ARRIVAL_RATE=$4
ALPHA=$5
STROBE_CNT=$6
LONG_WEIGHT=$7
LSA_R=$8
LR_range=$9

if [ $TRAFFIC_MODEL -eq 0 ]
then
    mkdir 0516\_traffic$TRAFFIC_MODEL\_period$PERIOD\_alpha$ALPHA\_strobe$STROBE_CNT
    cd 0516\_traffic$TRAFFIC_MODEL\_period$PERIOD\_alpha$ALPHA\_strobe$STROBE_CNT
else
    mkdir 0516\_traffic$TRAFFIC_MODEL\_rate$ARRIVAL_RATE\_alpha$ALPHA\_strobe$STROBE_CNT
    cd 0516\_traffic$TRAFFIC_MODEL\_rate$ARRIVAL_RATE\_alpha$ALPHA\_strobe$STROBE_CNT
fi

../param.sh $LONG_WEIGHT $ALPHA $STROBE_CNT $LSA_R $TRAFFIC_MODEL $PERIOD $ARRIVAL_RATE

if [ ! -e sr\_$topology ]
then
    mkdir lr\_$topology\_weight$LONG_WEIGHT\_LR_range$LR_range
fi
cd lr\_$topology\_weight$LONG_WEIGHT\_LR_range$LR_range
echo "#########################  We are in $PWD  ########################"

if [ ! -e COOJA.testlog ]
then
    java -mx512m -jar $CONTIKI/tools/cooja/dist/cooja.jar -nogui=$CONTIKI/lanada/sim_scripts/scripts/0502_$topology\_$LR_range\.csc -contiki="$CONTIKI"
fi
../../pp.sh
cd ../..

echo "Simulation finished"
