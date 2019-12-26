#!/bin/bash

echo "Starting..."

hostname=$@

echoerr() { echo "$@" 1>&2; }

create_table() {
    file_name=$@
    echo "Creating table with file: [$file_name]"
    result=$(aws dynamodb create-table --cli-input-json file:///json/$file_name --endpoint-url $hostname 2>&1)
    error=$(echo ${result} | grep -i 'Cannot create preexisting table')
    
    if [ -n "$error" ]
    then
        echoerr '### Error creating table, already exists!'
    else 
        echo 'Table created!'
    fi            
}

batch_write_items() {
    file_name=$@
    echo "Batch write items with file: [$file_name]"
    result=$(aws dynamodb batch-write-item --request-items file:///json/$file_name --endpoint-url $hostname 2>&1)
    echo "Items inserted! Log: $result"
}

cd /json

for file in `ls | sort -V`
do
    if [[ -f $file ]]; then
        command=$(echo $file | cut -d'-' -f2)
        
        if [ $command = 'ct' ] 
        then
            create_table $file
        fi

        if [ $command = 'bwi' ] 
        then
            batch_write_items $file
        fi
    fi
done
