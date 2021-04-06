# Download spark with aws support ( glue + S3 commiters )
download_spark_aws(){
# $1 - dest folder
# $2 - hadoop_version
# $3 - spark_version
[[ ! -d $1 ]] && return 1
hadoop_version="$2"
spark_version="$3"
aws_java_sdk_version="1.11.797"
HOME_DIR="$1/spark_home"
HADOOP_DIR="$HOME_DIR/hadoop-${hadoop_version}"
SPARK_DIR="$HOME_DIR/spark-${spark_version}"

HADOOP_LIB_DIR="$HADOOP_DIR/share/hadoop/tools/lib"

rm -rf "$HADOOP_DIR"
rm -rf "$SPARK_DIR"

mkdir -p "$HADOOP_DIR"
mkdir -p "$SPARK_DIR"

curl -sL https://github.com/bbenzikry/spark-glue/releases/download/${spark_version}/spark-${spark_version}-bin-hadoop-provided-glue.tgz | tar -xvzf - -C "$SPARK_DIR" --strip-components=1
curl -sL https://mirrors.whoishostingthis.com/apache/hadoop/common/hadoop-${hadoop_version}/hadoop-${hadoop_version}.tar.gz | tar -xvzf - -C "$HOME_DIR"

rm $HADOOP_LIB_DIR/aws-java-sdk-bundle-*.jar
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${aws_java_sdk_version}/aws-java-sdk-bundle-${aws_java_sdk_version}.jar -P "$HADOOP_LIB_DIR"

# cloud jar
wget https://github.com/bbenzikry/spark-glue/releases/download/${spark_version}/spark-hadoop-cloud_2.12-${spark_version}.jar -P "$SPARK_DIR/jars"
}