#!/bin/bash

LOCAL_BIN_PATH="${HOME}/.local/bin"
LOCAL_SHARE_PATH="${HOME}/.local/share"
SAVE_PATH="${HOME}/.dotfiles-bin"

[ ! -d "$SAVE_PATH" ] && mkdir -p $SAVE_PATH
[ ! -d "${HOME}/.local/bin" ] && mkdir -p ${HOME}/.local/bin

backup() {
    if [ -e "$1" ]; then
        rm -rf ${1}_bk
        mv -f $1 ${1}_bk
    fi
}

github_latest_url() {
    latest_url=`curl --proto '=https' --tlsv1.2 -sSLIf -o /dev/null -w '%{url_effective}' $1`
    echo "$latest_url" | sed "s/releases\/tag\//releases\/download\//g"
}

download() {
    curl -o ${1} --proto '=https' --tlsv1.2 -SLf ${2}
}

install_fonts() {
    dir_src="$( cd $1 >/dev/null 2>&1 && pwd )"
    filename_src=($2)
    filename_dst=($3)
    [ ! -d "$4" ] && mkdir -p $4
    for ((i=0; i<${#filename_src[*]}; i++))
    do
        cp -f $dir_src/${filename_src[i]} $4/$(echo ${filename_dst[i]} | awk -F '/' '{print $NF}')
    done
    fc-cache -fv
}

circulate_ln() {
    bin_dir="$(cd $1 >/dev/null 2>&1 && pwd)"
    bin=($2)
    bin_link=($3)
    [ ! -d "$4" ] && mkdir -p $4
    for ((i=0; i<${#bin[*]}; i++))
    do
        [ ! -x "$bin_dir/${bin[i]}" ] && chmod +x $bin_dir/${bin[i]}
        if [ "$5" == "hard" ]; then
            ln -f $bin_dir/${bin[i]} $4/$(echo ${bin_link[i]} | awk -F '/' '{print $NF}')
        else
            ln -sf $bin_dir/${bin[i]} $4/$(echo ${bin_link[i]} | awk -F '/' '{print $NF}')
        fi
    done
}

wrap_decompress() {
    local extension_name=$(echo $2 | awk -F '.' '{print $NF}')
    local content
    case "$extension_name" in
        "gz")
            if [ "$(echo $2 | awk -F '.' '{print $(NF -1)}')" == "tar" ]; then
                content=$(tar tf $2)
                decompress $1 $2 "$content" "tar zxf $2 -C $1" "tar zxf $2"
            else
                mkdir $1 && mv $2 $1
                pushd $1 && gzip -d $2 && popd
            fi
            ;;
        "tgz" | "tar" | "xz" | "bz2")
            content=$(tar tf $2)
            decompress $1 $2 "$content" "tar xf $2 -C $1" "tar xf $2"
            ;;
        "zst")
            content=$(tar tf $2)
            decompress $1 $2 "$content" "tar -I zstd -xf $2 -C $1" "tar -I zstd -xf $2"
            ;;
        "zip")
            content=$(zipinfo -1 $2)
            decompress $1 $2 "$content" "unzip $2 -d $1" "unzip $2"
            ;;
    esac
}

decompress() {
    is_wrapped "$3"
    if [ $? -ne 0 ]; then
        mkdir $1
        eval "$4"
    else
        wrapped_name=$(root_dir "$content" | awk -F '/' '{print $1F}')
        eval "$5"
        [ "$wrapped_name" == $(leaf_dir "$1") ] || mv $wrapped_name $1
    fi
}

is_wrapped() {
    root_file_num=$(root_file "$@" | wc -l)
    root_dir_num=$(root_dir "$@" | wc -l)
    if [ "$root_file_num" -eq 0 ] && [ "$root_dir_num" -eq 1 ]; then
        return 0
    fi
    return 1
}

root_dir() {
    echo "$@" | awk -F '/' '{if($1!="." && NF>1) print $1}' | uniq
}

root_file() {
    echo "$@" | awk -F '/' '{if($1!="." && NF==1) print $1}'
}

leaf_dir() {
    echo "$1" | awk -F '/' '{if($NF != "" ) print $NF; else print $(NF-1)}'
}

parent_dir(){
    echo "$1" | awk -F '/' '{r=""; tail=0; if($NF=="")tail=NF-2; else tail=NF-1; for(i=1;i<=tail;i++)r=r""$i"/"; print r}'
}
