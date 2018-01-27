#!/bin/bash
# https://www.shiyanlou.com/challenges/3881

targetDir="/home/zhaoguoyu/backup/";
targetTarName=`date "+%Y-%m-%d" `".tar"
srcDir="/var/log/"
DIR=`pwd`

cd $srcDir
sudo tar -cf $targetTarName  boot.log  yum.log anaconda.log
if [ ! -d "$targetDir" ];then
	mkdir -p $targetDir
fi

sudo mv $targetTarName  $targetDir

cd $DIR
