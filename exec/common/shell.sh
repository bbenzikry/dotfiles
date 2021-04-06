identify_shell(){
    ps h -p $$ -o args='' | cut -f1 -d' '
}