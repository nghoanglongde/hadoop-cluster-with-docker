FROM ubuntu:18.04

WORKDIR /root

RUN apt-get update && apt-get install -y \
    openssh-server \
    nano \
    openjdk-8-jdk

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# download hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz && \
    tar -xzf hadoop-2.7.7.tar.gz && \
    mv hadoop-2.7.7 /usr/local/hadoop && \
    rm hadoop-2.7.7.tar.gz

# set environment vars
ENV HADOOP_HOME=/usr/local/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin 

# copy hadoop configs
COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-cluster.sh ~/start-cluster.sh

# remove CRLF in file slaves
RUN sed -i 's/\r$//g' $HADOOP_HOME/etc/hadoop/slaves
RUN sed -i 's/\r$//g' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN sed -i 's/\r$//g' ~/start-cluster.sh

# format namenode
RUN $HADOOP_HOME/bin/hdfs namenode -format

