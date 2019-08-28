# hadoop-2.7.3.tar.gz
# http://archive.apache.org/dist/hadoop/core/hadoop-2.7.3/hadoop-2.7.3.tar.gz

# spark-2.0.1-bin-hadoop2.7.tgz
# http://archive.apache.org/dist/spark/spark-2.0.1/spark-2.0.1-bin-hadoop2.7.tgz

# hbase-1.2.5-bin.tar.gz 
# http://archive.apache.org/dist/hbase/1.2.5/hbase-1.2.5-bin.tar.gz 

# scala-2.11.8.tgz
# https://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz

# zookeeper-3.4.10.tar.gz
# http://archive.apache.org/dist/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz

# 构建Hadoop yarn spark Dockerfile文件内容
# Author:ywq

#基于centos7-ssh构建
FROM centos7-ssh

#配置各节点时间同步
RUN yum install -y ntp
#RUN systemctl is-enabled ntpd
#必须在run 容器时授权--privileged
#RUN systemctl enable ntpd
#RUN systemctl start ntpd
#docker容器与宿主机时区同步
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/shanghai" > /etc/timezone

#创建spark账号
RUN useradd spark
RUN echo "spark:12345678" | chpasswd

#对于Hbase 修改 ulimit 限制
RUN echo "spark  -      nofile  32768 " >> /etc/security/limits.conf
RUN echo "spark  -      nproc   32000" >>  /etc/security/limits.conf
RUN echo "session required pam_limits.so" >>  /etc/pam.d/common-session 

#安装java
ADD jdk-8u221-linux-x64.tar.gz /usr/local/
RUN mv /usr/local/jdk1.8.0_221 /usr/local/jdk1.8

#配置JAVA环境变量
ENV JAVA_HOME /usr/local/jdk1.8
ENV PATH $JAVA_HOME/bin:$PATH


#安装hadoop
ADD hadoop-2.7.3.tar.gz /usr/local
RUN mv /usr/local/hadoop-2.7.3 /usr/local/hadoop

#配置hadoop环境变量
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

#安装scala 注意Spark2.0.1对于Scala的版本要求是2.11.x
ADD scala-2.11.8.tgz /usr/local
RUN mv /usr/local/scala-2.11.8 /usr/local/scala2.11.8

#配置scala环境变量
ENV SCALA_HOME /usr/local/scala2.11.8
ENV PATH $SCALA_HOME/bin:$PATH

#安装spark
ADD spark-2.0.1-bin-hadoop2.7.tgz /usr/local
RUN mv /usr/local/spark-2.0.1-bin-hadoop2.7 /usr/local/spark2.0.1

#配置spark环境变量
ENV SPARK_HOME /usr/local/spark2.0.1
ENV PATH $SPARK_HOME/bin:$PATH

#安装ZooKeeper
ADD zookeeper-3.4.10.tar.gz /usr/local
RUN mv /usr/local/zookeeper-3.4.10 /usr/local/zookeeper3.4.10

#配置ZooKeeper环境变量
ENV ZOOKEEPERE_HOME /usr/local/zookeeper3.4.10
ENV PATH $ZOOKEEPERE_HOME/bin:$PATH

#安装HBase
ADD hbase-1.2.5-bin.tar.gz /usr/local
RUN mv /usr/local/hbase-1.2.5 /usr/local/hbase1.2.5

#配置Hbase环境变量
ENV HBASE_HOME /usr/local/hbase1.2.5
ENV PATH $HBASE_HOME/bin:$PATH


# bigdata configurations hdfs hbase zookeeper spark so on
ADD conf/hdfs_conf/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD conf/hdfs_conf/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD conf/hdfs_conf/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
ADD conf/hdfs_conf/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
ADD conf/hdfs_conf/slaves $HADOOP_HOME/etc/hadoop/slaves

ADD conf/spark_conf/spark-env.sh $SPARK_HOME/conf/spark-env.sh
ADD conf/spark_conf/slaves $SPARK_HOME/conf/slaves

ADD conf/zookeeper_conf/zoo.cfg $ZOOKEEPERE_HOME/conf/zoo.cfg

ADD conf/hbase_conf/hbase-site.xml $HBASE_HOME/conf/hbase-site.xml
ADD conf/hbase_conf/regionservers $HBASE_HOME/conf/regionservers

RUN echo "export JAVA_HOME=/usr/local/jdk1.8" >> $HBASE_HOME/conf/hbase-env.sh
RUN echo "export HBASE_MANAGES_ZK=false" >> $HBASE_HOME/conf/hbase-env.sh
RUN echo "export JAVA_HOME=/usr/local/jdk1.8" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh


#更改hadoop和spark2.0.1目录所属用户
RUN chown -R spark:spark /usr/local/hadoop
RUN chown -R spark:spark /usr/local/spark2.0.1
RUN chown -R spark:spark /usr/local/hbase1.2.5
RUN chown -R spark:spark /usr/local/zookeeper3.4.10

RUN yum install -y which sudo

# docker build -t="bigdata-cluster" .