#!/bin/bash

SR=1 # Decide whether SR simulation runs or not
LR=0 # For LR case
TRAFFIC=0 # 0 = periodic, 1 = poisson
VAR_PERIOD=(30)
VAR_ARRIVAL=(100)
VAR_LSA_R=0
VAR_STROBE_CNT=1
# SR_RANGE simulation

if [ $SR -eq 1 ]
then
    if [ $TRAFFIC -eq 0 ]
    then
	for period in $VAR_PERIOD
	do
	    for topology in 16linear 36grid 50random
	    do
		./sr_run.sh $topology $TRAFFIC $period  0 1 $VAR_STROBE_CNT
	    done
	done
    else
	for arrival in $VAR_ARRIVAL
	do
	    for topology in 16linear 36grid 50random
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
	    for topology in 16linear 36grid 50random
	    do
		for range in 2X
		do
		    for weight in 2
		    do
			./lr_run.sh $topology $TRAFFIC $period 0 1 $VAR_STROBE_CNT $weight $VAR_LSA_R $range
		    done
		done
	    done
	done
    else
	for arrival in $VAR_ARRIVAL
	do
	    for topology in 16linear 36grid 50random
	    do
		for range in 2X
		do
		    for weight in 2
		    do
			./lr_run.sh $topology $TRAFFIC 0 $arrival 1 $VAR_STROBE_CNT $weight $VAR_LSA_R $range
		    done
		done
	    done
	done
    fi
fi
