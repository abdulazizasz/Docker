#Set the basic image for the this Docker image 
FROM ubuntu:16.04

#Set the id of the maintainer of the image which can be assigned on the Docker Hub
MAINTAINER pedrobustamantes 

# Assign the user to run the system calls 
USER root 

#Installing the default version of JAVA
RUN apt-get update -y
RUN apt-get install default-jdk -y 


RUN apt-get install ssh -y
RUN apt-get install rsync -y

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys


#Getting Hadoop from one repository
RUN wget http://apache.claz.org/hadoop/common/stable/hadoop-2.7.3.tar.gz
RUN tar xfz hadoop-2.7.3.tar.gz
RUN mv hadoop-2.7.3 /usr/local/hadoop

#Setting the enviroment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd644
ENV HADOOP_INSTALL=/usr/local/hadoop
ENV PATH=$PATH:$HADOOP_INSTALL/bin
ENV PATH=$PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME=$HADOOP_INSTALL
ENV HADOOP_COMMON_HOME=$HADOOP_INSTALL
ENV HADOOP_HDFS_HOME=$HADOOP_INSTALL
ENV YARN_HOME=$HADOOP_INSTALL
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
 
#Configuring Haddop adding the different configuration files
ADD core-site.xml usr/local/hadoop/etc/hadoop/
ADD yarn-site.xml usr/local/hadoop/etc/hadoop/
ADD mapred-site.xml usr/local/hadoop/etc/hadoop/
ADD hdfs-site.xml usr/local/hadoop/etc/hadoop/
ADD hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN chown root:root /usr/local/hadoop/etc/hadoop/hadoop-env.sh
RUN chmod 700 /usr/local/hadoop/etc/hadoop/hadoop-env.sh


#Creating the directories for Hadoop Nodes
RUN mkdir -p /usr/local/hadoop_store/hdfs/namenode
RUN mkdir -p /usr/local/hadoop_store/hdfs/datanode

ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
ENV BOOTSTRAP /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh","-d"]

EXPOSE 50010
