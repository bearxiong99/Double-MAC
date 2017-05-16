#!/bin/bash

SR=0 # Decide whether SR simulation runs or not
LR=1 # For LR case
TRAFFIC=0 # 0 = periodic, 1 = poisson
VAR_PERIOD=(30)
VAR_ARRIVAL=(100)
VAR_TOPOLOGY=(16linear 36grid 50random)
VAR_LR_RANGE=(4X)
VAR_LR_WEIGHT=(2)
VAR_LSA_R=1
VAR_STROBE_CNT=1

# SR_RANGE simulation

if [ $SR -eq 1 ]
then
    if [ $TRAFFIC -eq 0 ]
    then
	for period in $VAR_PERIOD
	do
	    for topology in $VAR_TOPOLOGY
	    do
		./sr_run.sh $topology $TRAFFIC $period  0 1 $VAR_STROBE_CNT
	    done
	done
    else
	for arrival in $VAR_ARRIVAL
	do
	    for topology in $VAR_TOPOLOGY
	    do
		./sr_run.sh $topology $TRAFFIC 0 $arrival 1 $VAR_STROBE_CNT
	    done
	done
    fi
fi

# LR_RANGE simulation
if [ $LR -eq 1 ]
then
    if [ $TRAFFIC -eq 0 ]
    then
	for period in $VAR_PERIOD
	do
	    for topology in $VAR_TOPOLOGY
	    do
		for range in $VAR_LR_RANGE
		do
		    for weight in $VAR_LR_WEIGHT
		    do
			./lr_run.sh $topology $TRAFFIC $period 0 1 $VAR_STROBE_CNT $weight $VAR_LSA_R $range
		    done
		done
	    done
	done
    else
	for arrival in $VAR_ARRIVAL
	do
	    for topology in $VAR_TOPOLOGY
	    do
		for range in $VAR_LR_RANGE
		do
		    for weight in $VAR_LR_WEIGHT
		    do
			./lr_run.sh $topology $TRAFFIC 0 $arrival 1 $VAR_STROBE_CNT $weight $VAR_LSA_R $range
		    done
		done
	    done
	done
    fi
fi
