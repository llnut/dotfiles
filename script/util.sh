#!/bin/bash

LOCAL_BIN_PATH="${HOME}/.local/bin"
LOCAL_SHARE_PATH="${HOME}/.local/share"
SAVE_PATH="${HOME}/.dotfiles-bin"

mkdir -p "$SAVE_PATH" "${HOME}/.local/bin"

backup() {
    if [[ -e "$1" ]]; then
        rm -rf "${1}_bk"
        mv -f "$1" "${1}_bk"
    fi
}

github_latest_url() {
    local url
    url=$(curl --proto '=https' --tlsv1.2 -sSLIf -o /dev/null -w '%{url_effective}' "$1") || {
        echo "Error: failed to resolve latest release for $1" >&2
        return 1
    }
    local tag="${url##*/}"
    echo "${url%/tag/*}/download/$tag"
}

download() {
    curl -o "$1" --proto '=https' --tlsv1.2 -SLf "$2"
}

# circulate_ln BIN_DIR DEST_DIR [NAME[:LINK]...]
circulate_ln() {
    local bin_dir dest_dir spec name link
    bin_dir="$(cd "$1" && pwd)" || {
        echo "Error: directory $1 does not exist" >&2
        return 1
    }
    dest_dir="$2"
    shift 2
    mkdir -p "$dest_dir"
    for spec in "$@"; do
        name="${spec%%:*}"
        link="${spec#*:}"
        [[ ! -x "$bin_dir/$name" ]] && chmod +x "$bin_dir/$name"
        ln -sf "$bin_dir/$name" "$dest_dir/$link"
    done
}

# install_fonts SRC_DIR DEST_DIR [FONT_FILE...]
install_fonts() {
    local src_dir dest_dir font
    src_dir="$(cd "$1" && pwd)" || {
        echo "Error: directory $1 does not exist" >&2
        return 1
    }
    dest_dir="$2"
    shift 2
    mkdir -p "$dest_dir"
    for font in "$@"; do
        cp -f "$src_dir/$font" "$dest_dir/${font##*/}"
    done
    fc-cache -fv
}

_extract() {
    local archive="$1" dest="$2"
    local -a cmd
    case "$archive" in
        *.tar.gz|*.tgz)           cmd=(tar zxf "$archive") ;;
        *.tar.xz|*.tar.bz2|*.tar) cmd=(tar xf  "$archive") ;;
        *.tar.zst)                 cmd=(tar -I zstd -xf "$archive") ;;
        *.zip|*.vsix)              cmd=(unzip -q "$archive") ;;
        *) echo "Error: unsupported archive format: $archive" >&2; return 1 ;;
    esac
    if [[ -n "$dest" ]]; then
        mkdir -p "$dest"
        case "$archive" in
            *.zip|*.vsix) "${cmd[@]}" -d "$dest" ;;
            *)            "${cmd[@]}" -C "$dest" ;;
        esac
    else
        "${cmd[@]}"
    fi
}

wrap_decompress() {
    local dest="$1" archive="$2"

    # Plain .gz (not .tar.gz): just decompress in place
    if [[ "$archive" == *.gz && "$archive" != *.tar.gz ]]; then
        mkdir -p "$dest"
        mv "$archive" "$dest/"
        gzip -d "$dest/${archive##*/}"
        return
    fi

    local content
    case "$archive" in
        *.tar.gz|*.tgz|*.tar.xz|*.tar.bz2|*.tar|*.tar.zst) content=$(tar tf "$archive") ;;
        *.zip|*.vsix)                                         content=$(zipinfo -1 "$archive") ;;
        *) echo "Error: unsupported archive format: $archive" >&2; return 1 ;;
    esac

    # Count unique root dirs/files; get wrapped dir name if exactly one root dir
    local n_dirs n_files wrapped_name
    read -r n_dirs n_files wrapped_name < <(
        awk -F/ '
            { sub(/^\.\//, "") }
            $0 == "" || $1 == "" { next }
            NF > 1 && !seen[$1]++ { n_dirs++; name = $1 }
            NF == 1 { n_files++ }
            END { print n_dirs+0, n_files+0, (n_dirs == 1 ? name : "") }
        ' <<< "$content"
    )

    if [[ $n_files -eq 0 && $n_dirs -eq 1 ]]; then
        _extract "$archive" ""
        [[ "$wrapped_name" != "$dest" ]] && mv "$wrapped_name" "$dest"
    else
        _extract "$archive" "$dest"
    fi
}

# gh_install [-n] [-t TAG] DIR RELEASE_URL REMOTE_PREFIX SUFFIX [BIN_SUBPATH [BIN[:LINK]...]]
#   -n            nightly: always re-download, no version caching
#   -t TAG        override resolved tag (for pre-computed URLs)
#   DIR           local directory name under $SAVE_PATH
#   RELEASE_URL   .../releases/latest (auto-resolved) or a fixed download base URL
#   REMOTE_PREFIX remote filename without suffix; use {TAG} as placeholder
#   SUFFIX        archive extension (.tar.gz, .zip, .gz …) or "" for bare binary
#   BIN_SUBPATH   subdir within extracted archive for binaries (default "")
#   BIN[:LINK]    binary names, "name" or "name:link" (default: DIR:DIR)
gh_install() {
    local nightly=0 force_tag=""
    while [[ "$1" == -* ]]; do
        case "$1" in
            -n) nightly=1; shift ;;
            -t) force_tag="$2"; shift 2 ;;
            *)  echo "gh_install: unknown option: $1" >&2; return 1 ;;
        esac
    done

    local dir="$1" url="$2" remote_prefix="$3" suffix="$4"
    local bin_subpath="${5:-}"
    (( $# >= 5 )) && shift 5 || shift $#

    echo "Installing $dir..."

    local save_dir="$SAVE_PATH/$dir"
    local bin_dir="$save_dir${bin_subpath:+/$bin_subpath}"
    local tag="" dl_url="$url"

    if [[ -n "$force_tag" ]]; then
        tag="$force_tag"
    elif [[ "$url" == *"/releases/latest" ]]; then
        dl_url=$(github_latest_url "$url") || return 1
        tag="${dl_url##*/}"
    elif (( nightly == 0 )); then
        tag="${url##*/}"
    fi

    local resolved_prefix="${remote_prefix/\{TAG\}/$tag}"

    local -a specs=()
    if [[ $# -eq 0 ]]; then
        specs=("$dir:$dir")
    else
        for b in "$@"; do
            local name="${b%%:*}" link="${b#*:}"
            specs+=("${name/\{TAG\}/$tag}:${link/\{TAG\}/$tag}")
        done
    fi

    if (( nightly == 0 )) && [[ -n "$tag" && -f "$save_dir/.$tag" ]]; then
        circulate_ln "$bin_dir" "$LOCAL_BIN_PATH" "${specs[@]}"
        echo "Already up-to-date."
        return
    fi

    backup "$save_dir"

    if [[ -n "$suffix" ]]; then
        (
            cd "$SAVE_PATH" || exit 1
            download "$SAVE_PATH/$dir$suffix" "$dl_url/$resolved_prefix$suffix" || {
                echo "Error: download failed for $dir" >&2
                exit 1
            }
            wrap_decompress "$dir" "$dir$suffix"
            rm -f "$SAVE_PATH/$dir$suffix"
        ) || return 1
    else
        mkdir -p "$save_dir"
        download "$save_dir/$dir" "$dl_url/$resolved_prefix" || {
            echo "Error: download failed for $dir" >&2
            return 1
        }
    fi

    circulate_ln "$bin_dir" "$LOCAL_BIN_PATH" "${specs[@]}"
    (( nightly == 0 )) && [[ -n "$tag" ]] && touch "$save_dir/.$tag"
    echo "Installation successful."
}

# gh_install_fonts DIR RELEASE_URL REMOTE_PREFIX SUFFIX FONT_FILE...
gh_install_fonts() {
    local dir="$1" url="$2" remote_prefix="$3" suffix="$4"
    shift 4
    local -a fonts=("$@")

    echo "Installing $dir..."

    local save_dir="$SAVE_PATH/$dir"
    local dl_url tag
    dl_url=$(github_latest_url "$url") || return 1
    tag="${dl_url##*/}"
    local resolved_prefix="${remote_prefix/\{TAG\}/$tag}"

    if [[ -f "$save_dir/.$tag" ]]; then
        install_fonts "$save_dir" "$LOCAL_SHARE_PATH/fonts" "${fonts[@]}"
        echo "Already up-to-date."
        return
    fi

    backup "$save_dir"
    (
        cd "$SAVE_PATH" || exit 1
        download "$SAVE_PATH/$dir$suffix" "$dl_url/$resolved_prefix$suffix" || {
            echo "Error: download failed for $dir" >&2
            exit 1
        }
        wrap_decompress "$dir" "$dir$suffix"
        rm -f "$SAVE_PATH/$dir$suffix"
    ) || return 1

    install_fonts "$save_dir" "$LOCAL_SHARE_PATH/fonts" "${fonts[@]}"
    touch "$save_dir/.$tag"
    echo "Installation successful."
}
