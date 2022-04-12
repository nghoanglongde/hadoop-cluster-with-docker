# Run Hadoop Cluster within Docker

![Untitled Workspace (6)](https://user-images.githubusercontent.com/43443323/149797286-f8f06715-8366-4f11-87e4-822bc4772a1e.png)

This is the implementation of hadoop cluster (1 masternode, 2 slaves node) using Docker

# Follow this steps on Windows 10
### 1. pull docker image

```
docker pull ghcr.io/nghoanglong/hadoop-cluster-with-docker/hadoop-cluster:latest
```

### 2. clone github repo

```
https://github.com/nghoanglong/hadoop-cluster-with-docker.git
```

### 3. create hadoop network

```
docker network create --driver=bridge hadoop
```

### 4. start container

```
cd hadoop-cluster-with-docker
bash start-container.sh
```

#### output
```
start hadoop-master container...
start hadoop-slave1 container...
start hadoop-slave2 container...
root@hadoop-master:~# 
```
+ It started 1 master node and 2 slaves node
+ You will get into the /root directory of hadoop-master container

### 5. start and stop hadoop
```
# when you are in hadoop-master, run this command

# for starting hadoop
start-all.sh

# for stopping hadoop
stop-all.sh
```
### 6. put example file to cluster
```
# when you are in hadoop-master, run this command

echo "demo file" >>> demo.txt

hdfs dfs -put demo.txt .

# check the file exists in cluster at [/] directory
hdfs dfs -ls /
```
### 7. access ports
http://localhost:50070/
http://localhost:8088/