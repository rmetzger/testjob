

echo "Preparing the work environment"

. config.sh

echo "checking if FILES_DIRECTORY exists"
if [[ ! -f $FILES_DIRECTORY]]; then
	mkdir $FILES_DIRECTORY;
fi

cd $FILES_DIRECTORY

STRATO_DIR=$FILES_DIRECTORY"/stratosphere"

echo "+++ preparing Stratosphere +++"

echo "checking if strato dir exists ($STRATO_DIR)"
if [[ ! -f $STRATO_DIR]]; then
	echo "Cloning stratosphere"
	git clone $GIT_REPO
fi

echo "Going into strato dir, fetching and checking out."
cd stratosphere
git fetch $GIT_BRANCH
git checkout origin/$GIT_BRANCH

echo "building stratosphere"
$MVN_BIN clean install -DskipTests


echo "+++ preparing the testjob +++"

cd $FILES_DIRECTORY

TESTJOB_DIR=$FILES_DIRECTORY"/testjob"
echo "checking if strato dir exists ($TESTJOB_DIR)"
if [[ ! -f $TESTJOB_DIR]]; then
	echo "Cloning testjob"
	git clone $TESTJOB_REPO
fi
cd $TESTJOB_DIR
git fetch $TESTJOB_REPO
git checkout origin/$TESTJOB_BRANCH

echo "building testjob"
$MVN_BIN clean package

cd $FILES_DIRECTORY
