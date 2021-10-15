#! /bin/bash
# file.txt
if [ $# -ne 1 ]; then
    echo "There are either more than or less than 1 argument were given"
    exit 1 
fi 

if [ ! -f $1 ]; then 
    echo "The file is invalid"
    exit 1
fi

dict_name="/usr/share/dict/words"
touch $1.spelling 

while IFS=' ' read -ra line; 
do
    for word in "${line[@]}";
    do
        new=$(echo $word | tr -cd '[[a-zA-Z]]')
        if [ ! -z $new ]; then
            check=$(grep -wic $new $dict_name)
            if [ $check -eq 0 ]; then 
                echo $new >> $1.spelling
            fi 
        fi 
    done;
done < $1temp

wc -w $1.spelling 

## final step : find unique number 
#sort $1.spelling | uniq -c | wc -l

exit 0 