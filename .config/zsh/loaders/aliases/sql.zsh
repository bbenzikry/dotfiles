# alias sqlline="$HOME/.zinit/plugins/julianhyde---sqlline/bin/sqlline"
function sqlline(){
        SQLLINE_PATH="$(dirname $ZINIT_HOME)/plugins/julianhyde---sqlline"
        java -cp "$SQLLINE_PATH/target/*" sqlline.SqlLine "$@"
}