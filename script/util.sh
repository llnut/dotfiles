#!/bin/bash
# Shared helpers for the per-tool install scripts. Each script sources this
# file and calls gh_install or gh_install_fonts with named arguments.

readonly LOCAL_BIN_PATH="${HOME}/.local/bin"
readonly LOCAL_SHARE_PATH="${HOME}/.local/share"
readonly SAVE_PATH="${HOME}/.dotfiles-bin"

_err() {
    printf 'Error: %s\n' "$*" >&2
}

backup() {
    if [[ -e "$1" ]]; then
        rm -rf "${1}_bk"
        mv -f "$1" "${1}_bk"
    fi
}

# Resolve the redirect of a GitHub releases/latest URL into the matching
# releases/download/<tag> base URL.
github_latest_url() {
    local url
    url=$(curl --proto '=https' --tlsv1.2 -sSLIf -o /dev/null -w '%{url_effective}' "$1") || {
        _err "failed to resolve latest release for $1"
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
        _err "directory $1 does not exist"
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
        _err "directory $1 does not exist"
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
        *.tar.gz | *.tgz) cmd=(tar zxf "$archive") ;;
        *.tar.xz | *.tar.bz2 | *.tar) cmd=(tar xf "$archive") ;;
        *.tar.zst) cmd=(tar -I zstd -xf "$archive") ;;
        *.zip | *.vsix) cmd=(unzip -q "$archive") ;;
        *)
            _err "unsupported archive format: $archive"
            return 1
            ;;
    esac
    if [[ -n "$dest" ]]; then
        mkdir -p "$dest"
        case "$archive" in
            *.zip | *.vsix) "${cmd[@]}" -d "$dest" ;;
            *) "${cmd[@]}" -C "$dest" ;;
        esac
    else
        "${cmd[@]}"
    fi
}

wrap_decompress() {
    local dest="$1" archive="$2"

    # Plain .gz, not .tar.gz: decompress in place.
    if [[ "$archive" == *.gz && "$archive" != *.tar.gz ]]; then
        mkdir -p "$dest"
        mv "$archive" "$dest/"
        gzip -d "$dest/${archive##*/}"
        return
    fi

    local content
    case "$archive" in
        *.tar.gz | *.tgz | *.tar.xz | *.tar.bz2 | *.tar | *.tar.zst) content=$(tar tf "$archive") ;;
        *.zip | *.vsix) content=$(zipinfo -1 "$archive") ;;
        *)
            _err "unsupported archive format: $archive"
            return 1
            ;;
    esac

    # Count unique root entries; capture the wrapped dir name when the archive
    # holds exactly one top-level directory and no top-level files.
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

# Substitute {TAG} and {VERSION} placeholders in a template string.
_subst_tag() {
    local s="$1" tag="$2" version="$3"
    s="${s//\{TAG\}/$tag}"
    s="${s//\{VERSION\}/$version}"
    printf '%s' "$s"
}

# Resolve the download base URL and release tag from --repo/--url inputs.
# _resolve_source BASE_VAR TAG_VAR REPO URL TAG NIGHTLY
# BASE_VAR and TAG_VAR are passed by name; callers must not name their output
# variables __gh_base_out or __gh_tag_out to avoid a nameref self-reference.
_resolve_source() {
    local -n __gh_base_out="$1" __gh_tag_out="$2"
    local repo="$3" url="$4" nightly="$6"
    __gh_tag_out="$5"

    if [[ -n "$repo" ]]; then
        if ((nightly)); then
            __gh_base_out="https://github.com/$repo/releases/download/nightly"
        elif [[ -n "$__gh_tag_out" ]]; then
            __gh_base_out="https://github.com/$repo/releases/download/$__gh_tag_out"
        else
            local latest
            latest=$(github_latest_url "https://github.com/$repo/releases/latest") || return 1
            __gh_tag_out="${latest##*/}"
            __gh_base_out="$latest"
        fi
        # An explicit --url overrides the download base but keeps the resolved tag.
        [[ -n "$url" ]] && __gh_base_out="$url"
    else
        __gh_base_out="$url"
        if ((nightly == 0)) && [[ -z "$__gh_tag_out" ]]; then
            __gh_tag_out="${url##*/}"
        fi
    fi
    return 0
}

_gh_install_usage() {
    cat >&2 << 'EOF'
Usage: gh_install --name NAME (--repo OWNER/REPO | --url BASE) --asset PREFIX
                  [--ext EXT] [--subdir PATH] [--bin NAME[:LINK]]...
                  [--nightly] [--tag TAG] [-h|--help]

Arguments:
  --name NAME        Local directory under the bin store, also the default binary name.
  --repo OWNER/REPO  GitHub repository; resolves releases/latest into a download URL.
  --url BASE         Explicit download base URL; an escape hatch for non-standard layouts.
  --asset PREFIX     Asset file name without the extension. Supports {TAG} and {VERSION}.
  --ext EXT          Archive extension such as .tar.gz, .zip, .gz. Omit for a bare binary.
  --subdir PATH      Sub-directory inside the extracted archive holding the binaries.
  --bin NAME[:LINK]  Binary to link, repeatable. Defaults to NAME:NAME. Supports {TAG}/{VERSION}.
  --nightly          Always re-download, skip version caching.
  --tag TAG          Force a specific tag instead of resolving the latest release.

Placeholders:
  {TAG}      Resolved release tag, e.g. v1.2.3.
  {VERSION}  Tag without a leading v, e.g. 1.2.3.
EOF
}

gh_install() {
    local name="" repo="" url="" asset="" ext="" subdir="" tag="" nightly=0
    local -a bins=()

    while (($#)); do
        case "$1" in
            --name=*) name="${1#*=}" ;;
            --name) name="$2"; shift ;;
            --repo=*) repo="${1#*=}" ;;
            --repo) repo="$2"; shift ;;
            --url=*) url="${1#*=}" ;;
            --url) url="$2"; shift ;;
            --asset=*) asset="${1#*=}" ;;
            --asset) asset="$2"; shift ;;
            --ext=*) ext="${1#*=}" ;;
            --ext) ext="$2"; shift ;;
            --subdir=*) subdir="${1#*=}" ;;
            --subdir) subdir="$2"; shift ;;
            --tag=*) tag="${1#*=}" ;;
            --tag) tag="$2"; shift ;;
            --bin=*) bins+=("${1#*=}") ;;
            --bin) bins+=("$2"); shift ;;
            --nightly) nightly=1 ;;
            -h | --help) _gh_install_usage; return 0 ;;
            *) _err "gh_install: unknown argument: $1"; _gh_install_usage; return 1 ;;
        esac
        shift
    done

    [[ -n "$name" ]] || { _err "gh_install: --name is required"; return 1; }
    [[ -n "$asset" ]] || { _err "gh_install: --asset is required"; return 1; }
    [[ -n "$repo" || -n "$url" ]] || { _err "gh_install: --repo or --url is required"; return 1; }

    echo "Installing $name..."
    mkdir -p "$SAVE_PATH" "$LOCAL_BIN_PATH"

    local dl_base="" rtag=""
    _resolve_source dl_base rtag "$repo" "$url" "$tag" "$nightly" || return 1

    local version="${rtag#v}"
    local resolved_asset
    resolved_asset=$(_subst_tag "$asset" "$rtag" "$version")

    local -a specs=()
    if ((${#bins[@]} == 0)); then
        specs=("$name:$name")
    else
        local spec name_part link_part
        for spec in "${bins[@]}"; do
            name_part=$(_subst_tag "${spec%%:*}" "$rtag" "$version")
            link_part=$(_subst_tag "${spec#*:}" "$rtag" "$version")
            specs+=("$name_part:$link_part")
        done
    fi

    local save_dir="$SAVE_PATH/$name"
    local bin_dir="$save_dir${subdir:+/$subdir}"

    if ((nightly == 0)) && [[ -n "$rtag" && -f "$save_dir/.$rtag" ]]; then
        circulate_ln "$bin_dir" "$LOCAL_BIN_PATH" "${specs[@]}"
        echo "Already up-to-date."
        return 0
    fi

    backup "$save_dir"

    local remote="$dl_base/$resolved_asset$ext"
    if [[ -n "$ext" ]]; then
        (
            cd "$SAVE_PATH" || exit 1
            download "$SAVE_PATH/$name$ext" "$remote" || {
                _err "download failed for $name"
                exit 1
            }
            wrap_decompress "$name" "$name$ext"
            rm -f "$SAVE_PATH/$name$ext"
        ) || return 1
    else
        mkdir -p "$save_dir"
        download "$save_dir/$name" "$remote" || {
            _err "download failed for $name"
            return 1
        }
    fi

    circulate_ln "$bin_dir" "$LOCAL_BIN_PATH" "${specs[@]}"
    ((nightly == 0)) && [[ -n "$rtag" ]] && touch "$save_dir/.$rtag"
    echo "Installation successful."
}

_gh_install_fonts_usage() {
    cat >&2 << 'EOF'
Usage: gh_install_fonts --name NAME (--repo OWNER/REPO | --url BASE) --asset PREFIX
                        --ext EXT --font FILE... [--tag TAG] [-h|--help]

Arguments:
  --name NAME        Local directory under the bin store.
  --repo OWNER/REPO  GitHub repository; resolves releases/latest into a download URL.
  --url BASE         Explicit download base URL.
  --asset PREFIX     Asset file name without the extension. Supports {TAG} and {VERSION}.
  --ext EXT          Archive extension such as .tar.xz.
  --font FILE        Font file to install, repeatable.
  --tag TAG          Force a specific tag instead of resolving the latest release.
EOF
}

gh_install_fonts() {
    local name="" repo="" url="" asset="" ext="" tag=""
    local -a fonts=()

    while (($#)); do
        case "$1" in
            --name=*) name="${1#*=}" ;;
            --name) name="$2"; shift ;;
            --repo=*) repo="${1#*=}" ;;
            --repo) repo="$2"; shift ;;
            --url=*) url="${1#*=}" ;;
            --url) url="$2"; shift ;;
            --asset=*) asset="${1#*=}" ;;
            --asset) asset="$2"; shift ;;
            --ext=*) ext="${1#*=}" ;;
            --ext) ext="$2"; shift ;;
            --tag=*) tag="${1#*=}" ;;
            --tag) tag="$2"; shift ;;
            --font=*) fonts+=("${1#*=}") ;;
            --font) fonts+=("$2"); shift ;;
            -h | --help) _gh_install_fonts_usage; return 0 ;;
            *) _err "gh_install_fonts: unknown argument: $1"; _gh_install_fonts_usage; return 1 ;;
        esac
        shift
    done

    [[ -n "$name" ]] || { _err "gh_install_fonts: --name is required"; return 1; }
    [[ -n "$asset" ]] || { _err "gh_install_fonts: --asset is required"; return 1; }
    [[ -n "$ext" ]] || { _err "gh_install_fonts: --ext is required"; return 1; }
    [[ -n "$repo" || -n "$url" ]] || { _err "gh_install_fonts: --repo or --url is required"; return 1; }
    ((${#fonts[@]})) || { _err "gh_install_fonts: at least one --font is required"; return 1; }

    echo "Installing $name..."
    mkdir -p "$SAVE_PATH"

    local dl_base="" rtag=""
    _resolve_source dl_base rtag "$repo" "$url" "$tag" 0 || return 1

    local version="${rtag#v}"
    local resolved_asset
    resolved_asset=$(_subst_tag "$asset" "$rtag" "$version")

    local save_dir="$SAVE_PATH/$name"
    if [[ -n "$rtag" && -f "$save_dir/.$rtag" ]]; then
        install_fonts "$save_dir" "$LOCAL_SHARE_PATH/fonts" "${fonts[@]}"
        echo "Already up-to-date."
        return 0
    fi

    backup "$save_dir"
    (
        cd "$SAVE_PATH" || exit 1
        download "$SAVE_PATH/$name$ext" "$dl_base/$resolved_asset$ext" || {
            _err "download failed for $name"
            exit 1
        }
        wrap_decompress "$name" "$name$ext"
        rm -f "$SAVE_PATH/$name$ext"
    ) || return 1

    install_fonts "$save_dir" "$LOCAL_SHARE_PATH/fonts" "${fonts[@]}"
    [[ -n "$rtag" ]] && touch "$save_dir/.$rtag"
    echo "Installation successful."
}
