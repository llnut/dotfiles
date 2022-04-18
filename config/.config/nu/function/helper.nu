def nudown [] {
    fetch https://api.github.com/repos/nushell/nushell/releases | get assets | select name download_count
}

def nuver [] {
    version | pivot key value
}

def proxy_on [] {

}
