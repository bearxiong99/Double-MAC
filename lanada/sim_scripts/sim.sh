#!/bin/bash

#mkdir 0513_simulation_period20

CONTIKI=~/Desktop/Double-MAC

cd 0514_simulation_period10

for weight in 2
do
	for topology in 16linear 36grid 50random
	do
		for LR_range in 2X
		do
			for energy in 200 
			do
				for LS in S
				do
					if [ ! -e $topology\_E$energy\_LR$LR_range_\$LS\_W$weight ]
					then
						mkdir $topology\_E$energy\_LR$LR_range\_$LS\_W$weight
					fi
					cd  $topology\_E$energy\_LR$LR_range\_$LS\_W$weight
					echo "#########################  We are in $PWD  ########################"
					if [ ! -e COOJA.testlog ]
					then
						java -mx512m -jar $CONTIKI/tools/cooja/dist/cooja.jar -nogui=$CONTIKI/lanada/sim_scripts/0502_$topology\_$LR_range\.csc -contiki="$CONTIKI"
					fi
					cd ..
				done
			done
		done
	done
done

cd ..
echo "Simulation finished"
