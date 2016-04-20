#!/bin/bash


VERSION=hadoop-2.7.2

sudo yum update
sudo yum install java-devel

eval `ssh-agent -s`
chmod 600 hadoop.pem
ssh-add hadoop.pem

cd /home/ec2-user

wget http://mirror.metrocast.net/apache/hadoop/common/hadoop-2.7.2/hadoop-2.7.2-src.tar.gz

tar -xzf "$VERSION".tar.gz
sudo rm "$VERSION".tar.gz

mv hadoop-2.7.2 hadoop

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
export HADOOP_PREFIX=/home/ec2-user/hadoop



cd /home/ubuntu
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.95.x86_64/jre" >> .bashrc
echo "export HADOOP_PREFIX=/home/ec2-user/hadoop" >> .bashrc

source .bashrc

echo "export HADOOP_HOME=$HADOOP_PREFIX" >> .bashrc
echo "export HADOOP_COMMON_HOME=$HADOOP_PREFIX" >> .bashrc
echo "export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop" >> .bashrc
echo "export HADOOP_HDFS_HOME=$HADOOP_PREFIX" >> .bashrc
echo "export HADOOP_MAPRED_HOME=$HADOOP_PREFIX" >> .bashrc
echo "export HADOOP_YARN_HOME=$HADOOP_PREFIX" >> .bashrc
echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> .bashrc
echo "export HADOOP_CLASSPATH=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.95.x86_64/lib/tools.jar" >> .bashrc


source .bashrc


#modify hadoop-env.sh

cd /home/ec2-user/hadoop/etc/hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.95.x86_64/jre" >> hadoop-env.sh
echo "export HADOOP_PREFIX=/home/ec2-user/hadoop" >> hadoop-env.sh
echo "export HADOOP_HOME=$HADOOP_PREFIX" >> hadoop-env.sh
echo "export HADOOP_COMMON_HOME=$HADOOP_PREFIX" >> hadoop-env.sh
echo "export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop" >> hadoop-env.sh
echo "export HADOOP_HDFS_HOME=$HADOOP_PREFIX" >> hadoop-env.sh
echo "export HADOOP_MAPRED_HOME=$HADOOP_PREFIX" >> hadoop-env.sh
echo "export HADOOP_YARN_HOME=$HADOOP_PREFIX" >> hadoop-env.sh
echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> hadoop-env.sh


