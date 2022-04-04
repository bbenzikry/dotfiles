# Example use: neosql -u jdbc:neo4j://localhost:7687
function neosql(){
    JAR_PATH="$HOME/.local/share/jars/Neo4jJDBC42.jar"
    SQLLINE_PATH="$(dirname $ZINIT_HOME)/plugins/julianhyde---sqlline"
    CP="$SQLLINE_PATH/target/*:$JAR_PATH"
    java -cp "$CP" sqlline.SqlLine "$@"
}