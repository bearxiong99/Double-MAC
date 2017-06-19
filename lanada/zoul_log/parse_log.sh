#!/bin/bash

FILE=$1
MAX_NODE_NUMBER=50
node=2

cd $PWD
rm -rf parsing
mkdir parsing

while [ $node -le $MAX_NODE_NUMBER  ]
do
	cat $FILE | egrep "count: $node" > parsing/count$node
	if [ -z "`egrep -r " from $node "`"  ] 
	then
		let "node=$node+1"
		continue
	fi
	cat $FILE | egrep "from $node " > parsing/node$node
	echo $node
	let "node=$node+1"
done	

cd parsing
node=2
while [ $node -le $MAX_NODE_NUMBER  ]
do
	dir="node$node"
	DIR="count$node"
	
	if [ -e $dir ]
	then
		echo -n "$dir: "
		cat $dir | wc -l
		echo -n "$DIR: "
		cat $DIR | wc -l
		echo "-------------------------"
	fi
	let "node=$node+1"
done
