# Run Hadoop Cluster within Docker

![Untitled Workspace (6)](https://user-images.githubusercontent.com/43443323/149797286-f8f06715-8366-4f11-87e4-822bc4772a1e.png)

This is the implementation of hadoop cluster (1 masternode, 3 slaves node) using Docker

# Follow this steps on Windows 10
## 1. clone github repo

```
https://github.com/nghoanglong/hadoop-cluster-with-docker.git
```

## 2. start hadoop cluster

```
docker compose up
```

## Additional commands
```
# for starting hadoop
start-all.sh

# for stopping hadoop
stop-all.sh

# create new directory in HDFS
hdfs dfs -mkdir /dir_name

# check the file exists in cluster at [/] directory
hdfs dfs -ls /
```

## Example put file into HDFS
```
echo "demo file" >>> demo.txt

hdfs dfs -put demo.txt /
```
## Access Ports
Hadoop cluster: http://localhost:50070/

Resource Manager: http://localhost:8088/

## Example Mapreduce Running
Ref: https://longcnttbkhn.github.io/mapreduce-xu-ly-du-lieu-phan-tan/