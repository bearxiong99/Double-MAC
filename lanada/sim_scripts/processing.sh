for DIR in *
do
	if [ -d $DIR ]
	then
		echo "------------------- Entering to DIR $DIR ----------------------"
		cd $DIR

		for dir in *
		do
			if [ -d $dir ]
			then
				echo "@@@@@@@@@@@@@@@@@ Entering to dir $dir @@@@@@@@@@@@@@@@@@@@@"
				cd $dir
				../../pp.sh
				cd ..
			fi
		done

	cd ..
	fi
done

