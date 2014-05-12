
# This is a simple bash file containing configuration values as variables

GIT_REPO=https://github.com/stratosphere/stratosphere.git
GIT_BRANCH=master

TESTJOB_REPO=https://github.com/stratosphere/testjob.git
TESTJOB_BRANCH=master

# has to be a absolute path!
FILES_DIRECTORY=`pwd`/workdir
DISTRIBUTED_WORKING_DIRECTORY=file:///tmp/stratosphere-tests

MVN_BIN=mvn
