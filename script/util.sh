#!/bin/bash

function bk() {
    rm -rf ${1}_bk
    if [ -e $1 ]; then
        mv -f $1 ${1}_bk
    fi
}
