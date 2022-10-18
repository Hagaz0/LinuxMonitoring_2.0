#!/bin/bash

. ./clean.sh

re='^[1-3]$'

if [[ $# != 1 ]] 
then
	echo "Invalid number of arguments (expected 1, input $#)"
	exit 1
fi

if [[ !($1 =~ $re) ]]
then
	echo "Incorrect imput (input '1-3', cleaning method)"
	exit 1
fi

menu=$1
clean
