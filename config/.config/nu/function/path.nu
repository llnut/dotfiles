def set_path [path: string] {
    if ($nu.path | find $path) == '' {
        echo $path
        pathvar add $path
    } {}
}
set_path $'($nu.env.HOME)/.dotfiles/common/config/bin'
set_path $'($nu.env.HOME)/bin'

