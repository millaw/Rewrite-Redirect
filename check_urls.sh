#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <conf_file>"
    exit 1
fi

conf_file="$1"
live_file="live_urls.txt"
not_live_file="not_live_urls.txt"

# Clear the files if they exist
> $live_file
> $not_live_file

while IFS= read -r line; do
    if [[ $line =~ rewrite ]]; then
        url=$(echo $line | awk '{print $3}')
        status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")
        if [ "$status_code" -eq 200 ]; then
            echo "$url is live." >> $live_file
        else
            echo "$url is not live." >> $not_live_file
        fi
    fi
done < "$conf_file"

echo "Check completed. Results are in $live_file and $not_live_file."