#!/usr/bin/env bash 

if [ $# = 0 ] ; then
	echo "type $0 (y)[s/a/b/c](-) .."
	exit 0
fi

total="-15"
while [ $# -gt 0 ]; 
do
	tmp="10"
	key=$1
	while true 
	do
			case $key in 
				y*)tmp=`expr $tmp - 2`;key=`echo ${key:1}`;;
				s*)tmp=`expr $tmp + 4`;key=`echo ${key:1}`;;
				a*)tmp=`expr $tmp + 3`;key=`echo ${key:1}`;;
				b*)tmp=`expr $tmp + 2`;key=`echo ${key:1}`;;
				c*)tmp=`expr $tmp + 1`;key=`echo ${key:1}`;;
				d*)key=`echo ${key:1}`;;
				-*)tmp=`expr $tmp - 10`;key=`echo ${key:1}`;;
				*)break;;
			esac;
	done
	total=`expr $total + $tmp`
	shift;
done

echo $total


