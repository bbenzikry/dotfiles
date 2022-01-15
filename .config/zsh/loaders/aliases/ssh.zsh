# $1 PORT, $2 HOST
function ssh-forward(){
    ssh -L "$1:127.0.0.1:$1" "$2" -N -v -v
}