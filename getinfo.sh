#!/bin/bash

cpunum=`cat /proc/cpuinfo |grep "processor"|sort -u|wc -l`;
memory_total=`free -m | grep Mem | awk '{print $2}'`;
memory_free=`free -m | grep Mem | awk '{print $4}'`;
disk_size=`df -h | sed -n '3p' | awk '{print $1}'`;

system_bit=`getconf LONG_BIT`
process_num=`ps auxw | wc -l`
soft_num=`yum list installed | wc -l`
ip=`ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`

echo "\$bash getinfo.sh"
echo "cpu num: $cpunum";
echo "memory total: ${memory_total}M";
echo "memory free: ${memory_free}M";
echo 'disk size:' $disk_size;
echo 'system bit:' $system_bit;
echo 'process:' $process_num;
echo 'software num:' $soft_num;
echo 'ip:' $ip;
