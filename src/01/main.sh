#!/bin/bash

. ./generate.sh

if [[ $# != 6 ]] 
then
	echo "Invalid number of arguments (expected 6, input $#)"
	exit 1
fi

if [[ ($1 != /*) || !(-d $1) ]]
then
	echo "$1 is not an absolute path or directory"
	exit 1
fi

re='^[1-9]+$'

if [[ !($2 =~ $re) ]]
then
	echo "$2 is not an number"
	exit 1
fi

alph='^[a-z|A-Z][a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?$'

if [[ !($3 =~ $alph) ]]
then
	echo "$3: incorrect input"
	exit 1
fi

if [[ !($4 =~ $re) ]]
then
        echo "$4 is not an number"
        exit 1
fi

fialph="^[a-z|A-Z][a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]\.[a-z][a-z]?[a-z]?$"

if [[ !($5 =~ $fialph) ]]
then
	echo "$5: incorrect input"
	exit 1
fi

size='^[1-9][0-9]?$'

if [[ !($6 =~ $size) && ($6 != 100) ]]
then
	echo "$6: incorrect input (input size <= 100Kb)"
	exit 1
fi

link=$1
nest_dirs=$2
name_dirs=$3
num_of_files=$4
name_files=$5
size_files=$6

generate
