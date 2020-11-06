#!user/bin/bash

# Change directory to home
cd ~

#check for update

sudo apt update

#create opt dir 

mkdir -p opt

cd opt

# download from the following url:

wget http://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz

# Unzip the downloaded file:

tar -xvzf hadoop2.7.3.tar.gz

# Remove the .tar.gz file

rm -r hadoop-2.7.3.tar.gz

#Change to the unziped hadoop folder:

cd hadoop-2.7.3

# Edit the .bash_profile file by setting env for HADOOP:

echo "## HADOOP_HOME" >> .bash_profile.sh

echo "export HADOOP_HOME=/home/deward/opt/hadoop-2.7.3" >> .bash_profile.sh
echo "export HADOOP_INSTALL=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >>.bash_profile.sh
echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export YARN_HOME=$HADOOP_HOME" >> .bash_profile.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> .bash_profile.sh
echo "export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin" >> .bash_profile.sh

# Change directory to 

cd opt/hadoop-2.7.3/etc/hadoop

# Add Java home to the hadoop-env.sh file
## Search for export JAVA_HOME if seen return the value abd store it at search
## If not seen return blank

search = $(grep -s export JAVA_HOME* hadoop-env.sh)

replace = "export JAVA_HOME=/home/opt/jdk1.8.0_221"
filename="hadoop-env.sh"

if [[ $search = "" || $search != "" ]]; then
sed -i "s/$search/$replace/" $filename
fi

# Edit the core-site.xml file
echo "<configuration>" >> core-site.xml
echo "<property>"  >> core-site.xml
echo "<name>fs.default.name</name>"  >> core-site.xml
echo "<value>hdfs://localhost:9000</value>"  >> core-site.xml
echo "</property>" >> core-site.xml
echo "</configuration>"  >> core-site.xml

#Edit the hdfs-site.xml

echo "<configuration>" >> hdfs-site.xml
echo "<property>" >> hdfs-site.xml
echo "<name>dfs.replication</name>" >> hdfs-site.xml
echo "<value>1</value>" >> hdfs-site.xml
echo "</property>" >> hdfs-site.xml

echo "<property>" >> hdfs-site.xml
echo "<name>dfs.name.dir</name>" >> hdfs-site.xml
echo "<value>file:///home/opt/hadoop-2.7.3/hdfs/namenode</value>" >> hdfs-site.xml
echo "</property>" >> hdfs-site.xml

cho "<property>" >> hdfs-site.xml
echo "<name>dfs.name.dir</name>" >> hdfs-site.xml
echo "<value>file:///home/opt/hadoop-2.7.3/hdfs/datanode</value>" >> hdfs-site.xml
echo "</property>" >> hdfs-site.xml
echo "</configuration>" >> hdfs-site.xml

# Edit the  yarn-site.xml file

echo "<configuration>"" >> yarn-site.xml
echo "<property>" >> yarn-site.xml
echo "<name>yarn.nodemanager.aux-services</name>" >> yarn-site.xml
echo "<value>mapreduce_shuffle</value>" >> yarn-site.xml
echo "</property>" >> yarn-site.xml
echo "</configuration>" >> yarn-site.xml

#Change your admin rights:

chmod 777 opt/
cd opt/
chmod 777 hadoop-2.7.3
cd hadoop-2.7.3
mkdir hdfs
cd hdfs/
mkdir datanode 
mkdir namenode

# Add both datanode and namenode paths to the hdfs-site.xml configuration respectively

echo "<configuration>" >> hdfs-site.xml
echo "<property>" >> hdfs-site.xml
echo "<name>dfs.replication</name>" >> hdfs-site.xml
echo "<value>1</value>" >> hdfs-site.xml
echo "</property>" >> hdfs-site.xml

echo "<property>" >> hdfs-site.xml
echo "<name>dfs.name.dir</name>" >> hdfs-site.xml
echo "<value>file:///home/user/opt/hadoop-2.7.3/hdfs/namenode</value>" >> hdfs-site.xml
echo "</property>" >> hdfs-site.xml

echo "<property>">> hdfs-site.xml
echo "<name>dfs.name.dir</name>">> hdfs-site.xml
echo "<value>file:///home/user/opt/hadoop-2.7.3/hdfs/datanode</value>">> hdfs-site.xml
echo "</property>">> hdfs-site.xml
echo "</configuration>">> hdfs-site.xml

# Copy mapred-site.xml.template file:
cp mapred-site.xml.template mapred-site.xml

# Edit the mapred-site.xml

echo "<configuration>" >> mapred-site.xml
echo "<property>" >> mapred-site.xml
echo "<name>mapreduce.framework.name</name>" >> mapred-site.xml
echo "<value>yarn</value>" >> mapred-site.xml
echo "</property>" >> mapred-site.xml
echo "</configuration>" >> mapred-site.xml

# Edit yarn-site.xml

echo "<configuration>" >> yarn-site.xml
echo "<!-- Site specific YARN configuration properties -->" >> yarn-site.xml
echo "<property>" >> yarn-site.xml
echo "<name>yarn.nodemanager.aux-services</name>" >> yarn-site.xml
echo "<value>mapreduce_shuffle</value>" >> yarn-site.xml
echo "</property>" >> yarn-site.xml
echo "</configuration>" >> yarn-site.xml

# Source your bash_profile: 

source .bash_profile

hdfs namenode -format

source .bash_profile

# Create SSH Key:

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# Start both the hdfs and yarn

start-all.sh

#f it doesn’t work, install OpenSSH:

sudo apt-get install openssh-server

# See all the nodes:

jps

# Run to list files remenber that / means the hadoop root directory 

hdfs dfs -ls /

# Make a dir in the hdfs called test1

hdfs dfs -mkdir /test1

# Run to list files remenber that  

hdfs dfs -ls /









