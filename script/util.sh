#!/bin/bash

LOCAL_BIN_PATH="$HOME/.local/bin"
CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SAVE_PATH="$CUR_PATH/../bin"

[ ! -d "$SAVE_PATH" ] && mkdir -p $SAVE_PATH
[ ! -d "$HOME/.local/bin" ] && mkdir -p $HOME/.local/bin

function backup() {
    rm -rf ${1}_bk
    if [ -e "$1" ]; then
        mv -f $1 ${1}_bk
    fi
}

function github_latest_url() {
    latest_url=`curl --proto '=https' --tlsv1.2 -sSLIf -o /dev/null -w '%{url_effective}' $1`
    echo "$latest_url" | sed "s/releases\/tag\//releases\/download\//g"
}

function download() {
    curl -o ${1} --proto '=https' --tlsv1.2 -SLf ${2}
}

function circulate_ln() {
    bin_dir="$( cd $1 >/dev/null 2>&1 && pwd )"
    bin=($2)
    bin_link=($3)
    [ ! -d "$4" ] && mkdir -p $4
    for ((i=0; i<${#bin[*]}; i++))
    do
        [ ! -x "$bin_dir/$v" ] && chmod +x $bin_dir/$v
        if [ "$5" == "hard" ]; then
            ln -f $bin_dir/${bin[i]} $4/$(echo ${bin_link[i]} | awk -F '/' '{print $NF}')
        else
            ln -sf $bin_dir/${bin[i]} $4/$(echo ${bin_link[i]} | awk -F '/' '{print $NF}')
        fi
    done
}

function wrap_decompress() {
    extension_name=`echo $2 | awk -F '.' '{print $NF}'`
    if [ "$extension_name" == "gz" ]; then
        archive_format=`echo $2 | awk -F '.' '{print $(NF -1)}'`
        if [ "$archive_format" == "tar" ]; then
            content=`tar tf $2`
            decompress $1 $2 "$content" "tar zxf $2 -C $1" "tar zxf $2"
        else
            mkdir $1 && mv $2 $1
            pushd $1 && gzip -d $2 && popd
        fi
    elif [ "$extension_name" == "tgz" ]; then
        content=`tar tf $2`
        decompress $1 $2 "$content" "tar zxf $2 -C $1" "tar zxf $2"
    elif [ "$extension_name" == "tar" ]; then
        content=`tar tf $2`
        decompress $1 $2 "$content" "tar xf $2 -C $1" "tar xf $2"
    elif [ "$extension_name" == "xz" ]; then
        content=`tar tf $2`
        decompress $1 $2 "$content" "tar xf $2 -C $1" "tar xf $2"
    elif [ "$extension_name" == "bz2" ]; then
        content=`tar tf $2`
        decompress $1 $2 "$content" "tar jxf $2 -C $1" "tar jxf $2"
    elif [ "$extension_name" == "zst" ]; then
        content=`tar tf $2`
        decompress $1 $2 "$content" "tar -I zstd -xf $2 -C $1" "tar -I zstd -xf $2"
    elif [ "$extension_name" == "zip" ] || [ "$extension_name" == "vsix" ]; then
        content=`zipinfo -1 $2`
        decompress $1 $2 "$content" "unzip $2 -d $1" "unzip $2"
    fi
}

function decompress() {
    wrapped=`check_wrapped "$3"`
    if [ "$wrapped" == 0 ]; then
        mkdir $1
        eval "$4"
    else
        wrapped_name=`root_dir "$content" | awk -F '/' '{print $1F}'`
        eval "$5"
        [ "wrapped_name" == `leaf_dir "$1"` ] || mv $wrapped_name $1
    fi
}

function check_wrapped() {
    root_file_num=`root_file "$@" | wc -l`
    root_dir_num=`root_dir "$@" | wc -l`
    if [ "$root_file_num" == 0 ] && [ $root_dir_num == 1 ]; then
        echo 1
    else
        echo 0
    fi
}

function root_dir() {
    echo "$@" | awk -F '/' '{if($1!="." && NF>1) print $1}' | uniq
}

function root_file() {
    echo "$@" | awk -F '/' '{if($1!="." && NF==1) print $1}'
}

function leaf_dir() {
    echo "$1" | awk -F '/' '{if($NF != "" ) print $NF; else print $(NF-1)}'
}

function parent_dir(){
    echo "$1" | awk -F '/' '{r=""; tail=0; if($NF=="")tail=NF-2; else tail=NF-1; for(i=1;i<=tail;i++)r=r""$i"/"; print r}'
}
