#/bin/sh

echo "Uploading available test data to hdfs"

. ./config.sh
. ./utils.sh


createHDFSDirectory

if [[ -e "$FILES_WC_GEN" ]]; then
	echo "found generated wordcount data"
	$HADOOP_BIN fs -test -e $HDFS_WC
	probe=$?
	if [ $probe -ne 1 ]; then
		echo "There is already wordcount data in hdfs. Stopping ...";
		exit 1;
	fi
	echo "Uploading to hdfs"
	echo "doing $HADOOP_BIN fs -copyFromLocal $FILES_WC_GEN $HDFS_WC"
	$HADOOP_BIN fs -copyFromLocal $FILES_WC_GEN $HDFS_WC
fi 




