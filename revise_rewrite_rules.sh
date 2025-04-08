#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <conf_file>"
    exit 1
fi

conf_file="$1"
live_file="CompletedChecks/live_urls.txt"
not_live_file="CompletedChecks/not_live_urls.txt"
revised_conf_file="CompletedChecks/revised_${conf_file}"

# Clear the files if they exist
> $live_file
> $not_live_file
> $revised_conf_file

while IFS= read -r line; do
    if [[ $line =~ (rewrite|Redirect|RewriteRule) ]]; then
        url=$(echo $line | awk '{print $2}')
        status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")
        if [ "$status_code" -eq 200 ]; then
            echo "$url is live." >> $live_file
            if [[ ! $line =~ ^#rewrite ]]; then
                echo "$line" >> $revised_conf_file
            fi
        else
            echo "$url is not live." >> $not_live_file
        fi
    fi
done < "$conf_file"

echo "Check completed. Results are in $live_file, $not_live_file, and $revised_conf_file."
