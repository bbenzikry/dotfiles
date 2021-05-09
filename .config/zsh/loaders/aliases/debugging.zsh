alias dt="dtrace"
alias dtr="dtruss"

# Captures stdout from running process
capture() {
    sudo dtrace -p "$1" -qn '
        syscall::write*:entry
        /pid == $target && arg0 == 1/ {
            printf("%s", copyinstr(arg1, arg2));
        }
    '
}

# gdb w/ XDG 
alias gdb="gdb -n -x $XDG_CONFIG_HOME/gdb/init"
alias sigusr='kill -s SIGUSR1'

# Capture file use
snoop(){
    opensnoop -n $1
}

get_process_env(){
    ps eww -o command $1 | tr ' ' '\n'
}


file_info(){
    local bin_type=$(file $1 | awk '{a=match($0, $2); print substr($0,a)}')
    echo "File type: $bin_type"
}

hook_stdout(){
strace -ewrite -p $1 2>&1 | grep "write(1"
}
