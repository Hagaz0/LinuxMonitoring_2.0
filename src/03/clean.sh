#!/bin/bash

function log_file {
	if ! [ -e `pwd`/log.txt ]
	then
		echo "There is not log file in current directory"
		exit 1
	fi
	OLDIFS=IFS
	IFS=$'\n'

	for var in $(cat `pwd`/log.txt)
	do
		dir=$(echo $var | awk '{print $1}')
		if [[ $dir == "script" || dir == "duration:" ]]
		then
			continue
		fi
		rm -rf $dir
	done
	IFS=OLDIFS
}

function date_time {
	read -p "Enter start time in format \"yyyy-mm-dd hh:mm\":  " user_time_start
	read -p "Enter end time in format \"yyyy-mm-dd hh:mm\":  " user_time_end
        reg_for_date="^([0-9]{4})-(1[0-2]|0[1-9])-(3[01]|[12][0-9]|0[1-9])$"
        reg_for_time="^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$"

        if ! [[ `echo $user_time_start | awk '{print $1}'` =~  $reg_for_date &&\
	     `echo $user_time_start | awk '{print $2}'` =~  $reg_for_time &&\
	     `echo $user_time_end | awk '{print $1}'` =~  $reg_for_date &&\
	       `echo $user_time_end | awk '{print $2}'` =~  $reg_for_time ]]
	then
		echo "Incorrect input"
		exit 1
	fi
	find / -type d -maxdepth 3 -newermt "$user_time_start:00" ! -newermt "$user_time_end:59" 2>/dev/null -exec rm -rf {} +
}

function name_mask {
	read -p "Enter directory name: " dir_name
	read -p "Enter date of creation in format \"yyyy-mm-dd\": " user_date
	reg_for_date="^([0-9]{4})-(1[0-2]|0[1-9])-(3[01]|[12][0-9]|0[1-9])$"

	if [[ ${#dir_name} -lt 1 || ${dir_name} -gt 7 || !$(echo $user_date | awk '{print $1}') =~ $reg_for_date ]]
	then
		echo "Incorrect input"
		exit 1
	fi
	date_part=${user_date: -2}${user_date:5:2}${user_date:2:2}
	find / -type d -maxdepth 3 -name "$dir_name*_$date_part" 2>/dev/null -exec rm -rf {} +
}

function clean {
	case $menu in
		1) log_file ;;
		2) date_time ;;
		3) name_mask ;;
	esac
}
