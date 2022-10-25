declare -a nomes=("FLÁVIO " "NILTON " "NICOLLAS " "ALYSSON " "BLENDOW " "DANILO " "DAVI " "FILIPE " "GABRIEL " "GUSTAVO " "HENRICO " "JOÃO " "JORGE " "JÚLIO " "KALLEBE " "LUÍS " "LUIZ " "MATHEUS " "MAYCON " "OTÁVIO " "PAULO " "PEDRO " "SÁVIO " "SERGIO " "VANESSA " "VICTOR " "VINICIUS " "WELITON " "WEMERSON " "YURI" )
declare -a sobrenomes=("MOTTA" "FREITAS" "CRETTON" "SANTOS" "MENDES" "CARDOSO" "MEIRELES" "SOARES" "DEMARQUE" "SOUZA" "COSTA" "FRIZ" "JESUS" "NÁPOLES" "CORREIA" "BANDEIRA" "BRAGA" "SILVA" "CARDOZO" "CRUZ" "OLIVEIRA" "MARAZO" "RODRIGUES" "NETO" "MASSI" "LIMA" "AMORIM" "ALMEIDA" "FILHO" "AGUIAR")
Y=
lengthNome=${#nomes[@]}
lengthSobrenome=${#sobrenomes[@]}
div=$((Y+1))
declare -i counter=1

mkdir -p "log"
echo "1" > producer.txt
echo "0" > consumer.txt
echo "0" > buffer.txt

readvalue(){
    local value=$(cat $1)
    echo $value
}

checkBuffer(){
    declare -i buffer=$(readvalue buffer.txt)
    echo "buffer" $buffer "bufferSize" $bufferSize
    if [ "$buffer" == "16" ]; then
        echo "Buffer is full"
        echo "0" > producer.txt
        local producer=$(readvalue producer.txt)
        while [ "$producer" -eq "0" ]; do
            echo "Waiting for consumer"
            sleep 1
            producer=$(readvalue producer.txt)
        done
    fi
}

function wakeUpConsumer(){
    local consumer=$(readvalue consumer.txt)
    if [ "$consumer" -eq "0" ]; then
        echo "1" > consumer.txt
    fi
}

while true;do
    checkBuffer
    now=$(date +"%T")
    echo "NOME: ${nomes[$RANDOM%$lengthNome]}${sobrenomes[$RANDOM%$lengthSobrenome]} $now" >> log/$counter.txt
    declare -i buffer=$(readvalue buffer.txt)
    echo "$(($buffer+1))" > buffer.txt
    wakeUpConsumer
    counter=$((counter+1))
    R=$(($RANDOM%$div))
done
#teste demarque seila kkkkkkk chupapika