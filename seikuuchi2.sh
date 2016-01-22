#!/usr/bin/env bash 

if [ $# = 0 ] ; then
	echo "type $0 [-s] (kanmusu-id) [(taikuu value)]"
	echo "when you want to see ids, type $0 -id"
	exit 1
fi

if [ $1 = "-id" ] ; then
	echo "`awk '{printf("%14s : %s\n",$6,$1)}' < 'tousaisuu.txt' `"
	exit 0
fi

if [ $# -lt 2 ] ; then
	echo "type $0 [-s] (kanmusu-id) [(taikuu value)]"
	echo "when you want to see ids, type $0 -id"
	exit 1
fi

if [ $1 = "-s" ] ; then
	shift
	unsorted=`$0 $@`
	echo "$unsorted" | head -n 1
	echo "$unsorted" | tail -n +2 | sort -k1rn 

	exit 0
fi

data=`awk -v id=$1 '{if($1==id){print}}' < 'tousaisuu.txt'`
ary=($data)
if [ ${#ary[@]} -ne 6 ] ; then
	echo "given unexpected input"
	exit 1
fi 
echo "$data"

case $# in
	2)step=6;taikuuchi=($2 0 0 0);;
	3)step=2;taikuuchi=($2 $3 0 0);;
	4)step=1;taikuuchi=($2 $3 $4 0);;
	*)step=1;taikuuchi=($2 $3 $4 $5);;
esac

perm=`awk -v step=$step '{if(FNR%step==1){print}}' < 'perm.txt'`
echo "$perm"

echo "$perm" | while read line
do
	pos=($line)
	total=`./seikuuchi.sh -t ${ary[1]} ${taikuuchi[${pos[0]}]} ${ary[2]} ${taikuuchi[${pos[1]}]} ${ary[3]} ${taikuuchi[${pos[2]}]} ${ary[4]} ${taikuuchi[${pos[3]}]} `
	output=`echo "$total ${taikuuchi[${pos[0]}]} ${taikuuchi[${pos[1]}]} ${taikuuchi[${pos[2]}]} ${taikuuchi[${pos[3]}]} "`
	echo $output | awk '{printf("%4s : %4s %4s %4s %4s\n",$1,$2,$3,$4,$5)}'
done

exit 0 

