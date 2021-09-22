#!/bin/bash
filename='company.txt'
n=1
while read line; do
# reading each line

url="$line/api/application.wadl?detail=true"
file=$(basename $url)

response=$(curl -L -s -o $file -z $file $url -w "%{http_code}")

case "$response" in
        200) printf "Received valid $response code.Possibility of retrieving data at ==> $url\n" ;;
        301) do_something ;;
        304) printf "Received: HTTP $response (file unchanged) ==> $url\n" ;;
        404) printf "Received: HTTP $response (file not found) ==> $url\n" ;;
          *) printf "Received: HTTP $response ==> $url\n" ;;
esac
n=$((n+1))
done < $filename
