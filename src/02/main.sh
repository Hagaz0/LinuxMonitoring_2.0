#!/bin/bash

. ./generate.sh

if [[ $# != 3 ]]
then
	echo "Wrong number of parameters (expected 3)"
	exit 1
fi
export start_time=$(date +"%H:%M:%S")

alph='^[a-z|A-Z][a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?$'

if [[ !($1 =~ $alph) ]]
then
	echo "$1: incorrect input"
        exit 1
fi

fialph="^[a-z|A-Z][a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]?[a-z|A-Z]\.[a-z][a-z]?[a-z]?$"

if [[ !($2 =~ $fialph) ]]
then
        echo "$2: incorrect input"
        exit 1
fi

size='^[1-9][0-9]?$'

if [[ !($3 =~ $size) && ($3 != 100) ]]
then
        echo "$6: incorrect input (input size <= 100MB)"
        exit 1
fi

dir_name=$1
file_name=$2
size=$3
export SECONDS=0

generate
