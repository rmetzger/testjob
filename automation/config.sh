
# This is a simple bash file containing configuration values as variables

GIT_REPO=https://github.com/stratosphere/stratosphere.git
GIT_BRANCH=master

TESTJOB_REPO=https://github.com/rmetzger/testjob.git
TESTJOB_BRANCH=testAutomation

# has to be a absolute path!
FILES_DIRECTORY=`pwd`/workdir
HDFS_WORKING_DIRECTORY=file:///tmp/stratosphere-tests

MVN_BIN=mvn

#custom mvn flags (most likely -Dhadoop.profile=2 )
CUSTOM_STRATOSPHERE_MVN=""

HADOOP_BIN="/media/Store/data/Projekte/hadoop-2.4.0/bin/hadoop"

FILES_WC_GEN=$FILES_DIRECTORY"/wc-data/generated-wc.txt"

HDFS_WC=$HDFS_WORKING_DIRECTORY"/wc-in"

STRATOSPHERE_BUILD_HOME=$FILES_DIRECTORY"/stratosphere-build"



