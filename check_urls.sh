#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <conf_file> <type>"
    echo "Supported types: nginx, apache, htaccess"
    exit 1
fi

conf_file="$1"
type="$2"
live_file="CompletedChecks/live_urls.txt"
not_live_file="CompletedChecks/not_live_urls.txt"
revised_conf_file="CompletedChecks/revised_${conf_file}"

# Clear the files if they exist
> $live_file
> $not_live_file
> $revised_conf_file

# Determine the pattern based on the type
case "$type" in
    nginx)
        pattern="rewrite"
        ;;
    apache)
        pattern="Redirect"
        ;;
    htaccess)
        pattern="RewriteRule"
        ;;
    *)
        echo "Unsupported type: $type"
        echo "Supported types: nginx, apache, htaccess"
        exit 1
        ;;
esac

while IFS= read -r line; do
    if [[ $line =~ $pattern ]]; then
        url=$(echo $line | awk '{print $2}')
        status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$url")
        if [ "$status_code" -eq 200 ]; then
            echo "$url is live." >> $live_file
            echo "$line" >> $revised_conf_file
        else
            echo "$url is not live." >> $not_live_file
        fi
    fi
done < "$conf_file"

echo "Check completed. Results are in $live_file, $not_live_file, and $revised_conf_file."
