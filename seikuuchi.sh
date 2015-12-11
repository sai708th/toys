#!/usr/bin/env bash 

if [ $# = 0 ] ; then
	echo "type $0 [(slot value) (taikuu value)]"
	exit 1
fi

total=0
while [ $# -gt 1 ];
do
seikuuchi=`echo "scale=3;$2 * sqrt($1)" | bc | awk '{printf("%d",$1)}'`
total=`echo "$total + $seikuuchi" | bc `
echo "$seikuuchi "
shift;shift
done

echo $total

