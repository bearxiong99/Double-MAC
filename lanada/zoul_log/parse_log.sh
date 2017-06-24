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
    part1=`tail -1 $dir | cut -d'P' -f2`
    part2=`echo $part1 | cut -d':' -f2`
    parent=`echo $part2 | cut -d'f' -f1`

    echo "Parent of $dir: $parent"

    part3=`tail -1 $dir | cut -d'E' -f2`
    part4=`echo $part3 | cut -d':' -f2`
    energy=`echo $part4 | cut -d'P' -f1`
    echo "Final energy $dir: $energy"

    echo -n "$DIR: "
    cat $DIR | wc -l
    echo "-------------------------"
  fi  
  let "node=$node+1"
done

