#!/bin/bash

IFS=$'\n'
for v in $(docker image ls | tail -n +2); do
        full_name=$(echo $v | awk -F ' ' '{print $1}')
        name=$(echo $v | awk -F ' ' '{print $1}' | awk -F '/' '{ if ($NF == "") {print $1} else {print $NF}}')
        tag=$(echo $v | awk -F ' ' '{print $2}')
        docker save -o "${name}.${tag}.tar" "${full_name}:${tag}"
        echo "backup ${full_name}:${tag} as ${name}.${tag}.tar"
done
