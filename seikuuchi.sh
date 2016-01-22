#!/usr/bin/env bash 

if [ $# = 0 ] ; then
	echo "type $0 [(slot value) (taikuu value)]"
	echo "if you need only total value, type $0 -t [(slot value) (taikuu value)]"
	exit 1
fi

case $1 in
	-t)onlytotal=1;shift;;
	*)onlytotal=0;;
esac

total=0
while [ $# -gt 1 ];
do
seikuuchi=`echo "scale=3;$2 * sqrt($1)" | bc | awk '{printf("%d",$1)}'`
total=`echo "$total + $seikuuchi" | bc `
if [ $onlytotal = 0 ] ; then
	echo "$seikuuchi "
fi
shift;shift
done

echo $total

