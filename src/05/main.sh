#!/bin/bash

if [[ $# != 1 ]]
then
        echo "Invalid number of arguments (expected 1, input $#)"
        exit 1
fi

re='^[1-4]$'
if [[ !($1 =~ $re) ]]
then
	echo "Incorrect input (input 1-4)"
        exit 1
fi

case $1 in
	1) cat ../04/log*.txt | sort -k8 -r ;;
	2) cat ../04/log*.txt | awk '{print $1}' | uniq -u ;;
	3) cat ../04/log*.txt | grep -e "\" [45][0-9][0-9]" | awk '{print $6, $7}' ;;
	4) cat ../04/log*.txt | grep -e "\" [45][0-9][0-9]" | awk '{print $1}' | uniq -u ;;
esac
