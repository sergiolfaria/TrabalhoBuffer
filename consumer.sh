declare -i contador_log=1

readvalue() {
    local value=$(cat $1)
    echo $value
}

checkBuffer() {
    declare -i buffer=$(readvalue buffer.txt)
    echo "buffer" $buffer "bufferSize" $bufferSize
    if [ "$buffer" -eq "0" ]; then
        echo "0" >consumer.txt
        local consumer=$(readvalue consumer.txt)
        while [ "$consumer" -eq "0" ]; do
            echo "Waiting for producer"
           
            consumer=$(readvalue consumer.txt)
        done
    fi
}

function wakeUpProducer(){
    local producer=$(readvalue producer.txt)
    if [ "$producer" -eq "0" ]; then
        echo "1" > producer.txt
    fi
}

for ((i = 0; i == 0; i++)); do
    if [[ -e log.txt ]]; then
        rm -r log.txt
    fi
done

touch log.txt

while true; do

    checkBuffer
    rm "./log/${contador_log}.txt"
    contador_log=$(($contador_log + 1))
    hora=$(date +"%T")
    var_string_log=$(grep -i "nome" ./log/${contador_log}.txt)
    read -a vetor_string_log <<<$var_string_log
    line="${vetor_string_log[1]} ${vetor_string_log[2]} ${vetor_string_log[3]} $hora"
    echo $line >> log.txt
    declare -i buffer=$(readvalue buffer.txt)
    echo "$(($buffer-1))" > buffer.txt    
    wakeUpProducer

done
