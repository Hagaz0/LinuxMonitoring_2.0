#!/bin/bash

#link=$1
#nest_dirs=$2
#name_dirs=$3
#num_of_files=$4
#name_files=$5
#size_files=$6

function create_file {
        size_dd=$1
        file_name_dd=$2
	dd if=/dev/zero of=$file_name_dd bs=$size_dd count=1 2>/dev/zero
}

function log_it {
	if ! [ -e `pwd`/log.txt ]
       	then
        	touch `pwd`/log.txt
	fi

        log_path=$1
        log_size=$2

        if [[ $log_size == "0" ]]
	then
		echo "$log_path - `date +"%d %b %Y %H:%M:%S"`" >> `pwd`/log.txt
        else
	        echo "$log_path - `date +"%d %b %Y %H:%M:%S"` - $log_size" >> `pwd`/log.txt
        fi
}

function create {
	for (( i=0; i<$nest_dirs; i++ ))
	do
		mkdir $link/$name_dirs\_$date
		log_it $link/$name_dirs\_$date 0
		new_filename=$fname

		for (( j = 1; j <= $num_of_files; j++ ))
		do
			create_file $size_files"KB" $link/$name_dirs\_$date/$new_filename\_$date"."$extension
			log_it $link/$name_dirs\_$date/$new_filename\_$date"."$extension $size_files"KB"
			new_filename=$new_filename${new_filename: -1}
			root_size=$(df -k /root | tail -n1 | awk '{print $4}')
			if [[ $root_size -le 1048576 ]]
			then
				echo "No space on device"
				exit 1
			fi
		done
		name_dirs=$name_dirs${name_dirs: -1}
	done
}

function generate {
	export date=$(date +"%d%m%y")
	export root_size=$(df -k /root | tail -n1 | awk '{print $4}')
	if [[ $root_size -le 1048576 ]] 
	then
		echo "No space on device"
	        exit 
	fi
	for (( ; ${#name_dirs} < 4; ))
	do
		name_dirs=$name_dirs${name_dirs: -1}
	done
	fname=${name_files%.*}
	extension=${name_files#*.}
	for (( ; ${#fname} < 4; ))
	do
		name_files=${name_files:0:1}$name_files
		fname=${name_files%.*}
	done
	create
}
