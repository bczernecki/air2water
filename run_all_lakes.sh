#!/bin/bash

for i in "Charzykowskie" "Gardno" "Hancza" "Jeziorak" "Lubie" "Mikolajskie" "Selmet" "Sepolenskie" "Slawskie" "Studzieniczne"
do

echo $i

cp $i/input.txt .
#echo "tutaj uruchamiam air2water"
./air2water_v2.0.out 
rm $i/output_2/0* # this files are usually way too big for github...

echo -e "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
echo -e "ukonczono jezioro $i"
echo -e "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n"

done

