#!/bin/bash

function create_logs {
	records=$(shuf -i 100-1000 -n1)
	sec_count=1
	for ((i=1; i<=$records; ++i))
	do
		ip="$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1).$(shuf -i 1-255 -n1) - -"
		date="[$(date -d "$time $sec_count"sec"" +"%d/%b/%Y:%H:%M:%S") +0200]"
		sec_count=$((sec_count + 1))
		request="\"${methods[$(shuf -i 0-4 -n1)]} HTTP/1.1\""
		code="${answer_code[$(shuf -i 0-9 -n1)]} $(shuf -i 0-100000 -n1)"
		url="\"https://github.com/Hagaz0\" ${agents[$(shuf -i 0-8 -n1)]}"
		echo "$ip $date $request $code $url" >> $1
	done
	echo "$1 has been created"
}

if [[ $# != 0 ]]
then
	echo "Don't input arguments"
	exit 1
fi
export time=$(date +"%F %H:%M:%S")
export answer_code=(200 201 400 401 403 404 500 501 502 503)
export methods=( 'GET' 'POST' 'PUT' 'PATCH' 'DELETE' )
export agents=('Mozilla' 'Google' 'Chrome' 'Opera' 'Safari' 'Internet Explorer'
		'Microsoft Edge' 'Crawler and bot' 'Library and net tool')
for i in {1..5}
do
	time=$(date -d "$time 24hour" +"%F %H:%M:%S")
	touch log$i.txt
	create_logs log$i.txt
done

# 200 - Успешно, сервер успешно обработал запрос
# 201 - Создано, сервер успешно обработал запрос и создал новый ресурс
# 400 - Неверный запрос, не может быть понят сервером из-за некорректного синтаксиса
# 401 - Неавторизованный запрос, для доступа к документу необходимо вводить пароль или быть зарегистрированным пользователем
# 403 - Доступ к ресурсу запрещен, сервер отказывается обработать запрос, у пользователя нет прав на просмотр содержимого
# 404 - Ресурс не найден, сервер не может найти запрашиваемый ресурс
# 500 - Внутренняя ошибка сервера, сервер столкнулся с непредвиденным условием, которое не позволяет ему выполнить запрос
# 501 - Не реализовано, сервер не поддерживает функционал, который необходим для обработки запроса
# 502 - Неверный шлюз, сервер получил недопустимый ответ от следующего сервера в цепочке запросов, к которому обратился при попытке выполнить запрос
# 503 - Сервис недоступен, потому что сервер перегружен или на нём проводятся технические работы


