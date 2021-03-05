#!/bin/bash

## straightforward loading script that will generate logs and graphs on the ELK dashboard.

USER_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36"
while true
do
# generate directory traversal log
curl -kA "$USER_AGENT" -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" "https://localhost/attack$((RANDOM % 8)).js?name=/../../../../../etc/nginx.conf" >> /dev/null
sleep $((1 + $RANDOM % 2))
# generate SQL Injection log
curl -kA "$USER_AGENT" -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" "https://localhost/attack$((RANDOM % 8)).js?name=' OR 1 = 1" >> /dev/null
sleep $((1 + $RANDOM % 3))
# generate XSS log
curl -kA "$USER_AGENT" -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" "https://localhost/attack$((RANDOM % 8)).js?name=<script>" >> /dev/null
sleep $((1 + $RANDOM % 4))
if [ 3 -gt $((1 + $RANDOM % 6)) ]
then
# generate BOT possibly or disallowed user-agent
curl -k -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" https://localhost >> /dev/null
curl -kA "$USER_AGENT" -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" https://localhost >> /dev/null
fi
sleep $((1 + $RANDOM % 5))
curl -kA "$USER_AGENT" -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" "https://localhost" >> /dev/null
sleep $((1 + $RANDOM % 6))
if [ 3 -gt $((1 + $RANDOM % 6)) ]
then
# generate XSS log
curl -kA "$USER_AGENT" -H "X-Forwarded-For: $((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))" "https://localhost/attack$((RANDOM % 8)).js?name=<script>" >> /dev/null
fi
done

