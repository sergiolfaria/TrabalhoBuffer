#! /bin/bash

for ((i = 0; i == 0; i++)); do
    if [[ -e log.txt ]]; then
        rm -r log.txt
    fi
done
touch log.txt
i=1
while [ "$(ls -A ./log/)" != null ]; do

    sleep 10s
    hora=$(date +"%T")
    var_string_log=$(grep -i "nome" ./log/${i}.txt)
    read -a vetor_string_log <<<$var_string_log
    #echo ${vetor_string_log[@]}
    line="${vetor_string_log[1]} ${vetor_string_log[2]} ${vetor_string_log[3]} $hora"
    echo $line >> log.txt
    rm "./log/${i}.txt"
    i=$(($i + 1))

done