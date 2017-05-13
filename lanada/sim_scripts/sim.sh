#!/bin/bash

#mkdir 0513_simulation_period20

cd 0513_simulation_period20

for weight in 2
do
	for topology in 16Grid 36Linear 50Random
	do
		for LR_range in 2X 4X
		do
			for energy in 200 
			do
				for LS in LS S
				do
					mkdir "$topology\_E$energy\_LR$LR_range\_$LS\_W$weight"
				done
			done
		done
	done
done
