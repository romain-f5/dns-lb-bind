#! /bin/bash

# summary script runs curl to the nginx plus proxy instance
# nginx 1 should be hit 4x for every 2x for nginx 2 and every nginx 

rm -f nginx.txt
for i in {1..140}
do
curl -k https://localhost | grep -o 'nginx[^ <]\+' >> nginx.txt
done
echo "nginx 1 was hit the following amount of times:"
grep 1 nginx.txt | wc -l
echo "nginx 2 was hit the following amount of times:"
grep 2 nginx.txt | wc -l
echo "nginx 3 was hit the following amount of times:"
grep 3 nginx.txt | wc -l
