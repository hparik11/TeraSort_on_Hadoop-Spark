#!/bin/bash


eval `ssh-agent -s`

ssh-add hadoop.pem

sudo mdadm

sudo mdadm --create --verbose /dev/md0 --level=0 --name=MY_RAID --raid-devices=2 /dev/xvdb /dev/xvdc

sudo mkfs.ext4 -L MY_RAID /dev/md0

sudo mkdir -p /mnt/raid

sudo mount LABEL=MY_RAID /mnt/raid


sudo chmod 777 /mnt/raid/


rm -Rf /mnt/raid/hdfs/*
rm -Rf /mnt/raid/tmp/*

cd /mnt/raid/

mkdir -p hdfs
mkdir -p hdfs/namenode
mkdir -p hdfs/datanode
mkdir -p tmp
mkdir -p tmp/hadoop-ec2-user


