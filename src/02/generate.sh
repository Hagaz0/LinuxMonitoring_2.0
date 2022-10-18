#!/bin/bash

function log_it {
	if ! [ -e `pwd`/log.txt ]
	then
        	touch `pwd`/log.txt
	fi
        log_path=$1
        log_size=$2
	if [[ $log_size == "0" ]]
	then
		echo "$log_path - `date +"%F %H:%M:%S"`" >> `pwd`/log.txt
        else
		echo "$log_path - `date +"%F %H:%M:%S"` - $log_size" >> `pwd`/log.txt
        fi
}

function check_path_num {
	path_num=$(find / -maxdepth 3 -type d -perm -o+w 2>/dev/null ! \( -wholename "*/bin" -o -wholename "*/bin/*" -o -wholename "*/sbin/*" -o -wholename "*/proc/*" \) | wc -l)     
}

function create_file {
	size_dd=$1
	file_name_dd=$2
	dd if=/dev/zero of=$file_name_dd bs=$size_dd count=1 2>/dev/zero
}

function random_path {
	num=`shuf -i 1-$path_num -n1`
        while true
	do
		echo "random path"
	        path=`find / -maxdepth 3 -type d -perm -o+w 2>/dev/null ! \( -wholename "*/bin" -o -wholename "*/bin/*" -o -wholename "*/sbin/*" -o -wholename "*/proc/*" \) | sort -R | awk "(NR == $num)"`
        if ! (mkdir $path/$dir_name\_$current_date 2>/dev/null) 
	then
		num=$(( 1 + `shuf -i 1-$path_num -n1` ))
        else
	        break
        fi
        done
}

function final_output {
	end_time=$(date +"%H:%M:%S")
	duration=$SECONDS
	echo "script start time: $start_time" >> `pwd`/log.txt
	echo "script end time: $end_time" >> `pwd`/log.txt
	echo "duration: $(($duration / 60)) minutes and $(($duration % 60)) seconds" >> `pwd`/log.txt tail -n3 `pwd`/log.txt
	exit
}

function create {
	export path
	export path_num
	check_path_num

	for (( i=0; i<$dirs_num; i++ ))
	do
		random_path
		log_it $path/$dir_name\_$date 0
		new_filename=$fname
		files_num=$(shuf -i 1-100 -n1)

		for (( j=1; j<=$files_num; j++ ))
		do
			echo "create file"
			create_file $size"MB" $path/$dir_name\_$date/$new_filename\_$date"."$extension
			log_it $path/$dir_name\_$date/$new_filename\_$date"."$extension $size"mb"
			new_filename=$new_filename${new_filename: -1}
			root_size=$(df -k /root | tail -n1 | awk '{print $4}')
			if [[ $root_size -le 1048576 ]]
			then
				echo "final"
		            	final_output
	                fi
	        done
		echo "create dir"
		dir_name=$dir_name${dir_name: -1}
	done
	echo "you still have memory to mess up"
}

function generate {
	echo "generate"
	root_size=`df -k /root | tail -n1 | awk '{print $4}'`
	if [[ $root_size -le 1048576 ]]
       	then
		echo "No space on device"
	        exit 
	fi
	export date=$(date +"%d%m%y")
	export dirs_num=$(shuf -i 1-100 -n1)
	for (( ; ${#dir_name} < 4; ))
	do
                dir_name=$dir_name${dir_name: -1}
	done
	fname=${file_name%.*}
        extension=${file_name#*.}
        for (( ; ${#fname} < 4; ))
        do
		file_name=${file_name:0:1}$file_name	
		fname=${file_name%.*}
	done
	create
}
