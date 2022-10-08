#!/bin/bash

service php7.2-fpm start

service nginx start

while true; do
    sleep 1
done

