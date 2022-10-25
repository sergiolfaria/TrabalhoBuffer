 checkBuffer(){
    declare -i buffer=$(readvalue buffer.txt)
    echo "buffer" $buffer "bufferSize" $bufferSize
    if [ "$buffer" -eq "0" ]; then
        echo "0" > consumer.txt
        local consumer=$(readvalue consumer.txt)
        while [ "$consumer" -eq "0" ]; do
            echo "Waiting for consumer"
            sleep 1
            consumer=$(readvalue consumer.txt)
        done
    fi
}
 
local consumer=$(readvalue consumer.txt)
if [ "$consumer" -eq "0" ]; then
    echo "1" > consumer.txt
fi

function wakeUpProducer(){
    local Producer=$(readvalue producer.txt)
    if [ "$producer" -eq "0" ]; then
        echo "1" > producer.txt
    fi
}

while true;do
    checkBuffer
    declare -i buffer=$(readvalue buffer.txt)
    echo "$(($buffer-1))" > buffer.txt
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
done