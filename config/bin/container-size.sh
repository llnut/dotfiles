#!/bin/bash

containers=`docker ps -a | awk -F ' ' '{print $NF}'| tail -n +2`
i=0
for v in $(du -sh $(docker inspect $(docker ps -a | awk -F ' ' '{print $1}'| tail -n +2) | grep WorkDir | awk -F ' "' '{print $NF}' | awk -F '/work"' '{print $1}'))
do
    echo "${containers[$i]}" $v
    ((i++))
done

