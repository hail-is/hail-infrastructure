## XXXXX: Executing this file is insufficient, any double-pound comment requires
## manual action

sudo yum install git cmake gcc gcc-c++ java-1.8.0-openjdk-devel.x86_64 java-1.8.0-openjdk.x86_64
sudo update-alternatives --config java

# install nodejs--seems super sketchy but this is the recommended way

curl --silent --location https://rpm.nodesource.com/setup_7.x | sudo -E bash -
sudo yum install nodejs

# EPEL includes lots of useful stuff, like Haskell, but is disabled by default
# since its produced by the Fedora folks, not Amazon or RedHat sudo yum install

pandoc --enablerepo=epel

sudo pip install sphinx sphinx_rtd_theme notedown jupyter
sudo pip install --upgrade six

(cd /tmp/ && \
  curl -O http://d3kbcqa49mib13.cloudfront.net/spark-2.0.2-bin-hadoop2.7.tgz && \
  sudo mv spark-2.0.2-bin-hadoop2.7.tgz /usr/local/)

(cd /tmp/ && \
  curl -O http://www.well.ox.ac.uk/~gav/qctool/resources/qctool_v1.4-linux-x86_64.tgz \
  sudo mv qctool_v1.4-linux-x86_64/qctool /usr/local/bin/qctool)

(cd /tmp/ && \
  curl -O http://www.cog-genomics.org/static/bin/plink/plink1_linux_x86_64.zip
  sudo mv plink-1.07-x86_64/plink /usr/local/bin/plink)


## install & configure, gcloud, see this page:
## https://cloud.google.com/storage/docs/gsutil_install#linux

## copy over the `hail-tutorial-files`

export SPARK_HOME=/usr/local/spark-2.0.2-bin-hadoop2.7/
export HAIL_HOME=/tmp/hail/
PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.3-src.zip:$HAIL_HOME/python SPARK_CLASSPATH=$HAIL_HOME/build/libs/hail-all-spark.jar ./gradlew test shadowJar

