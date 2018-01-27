#!/bin/bash


if [ "$(whoami)" != "root" ]
then
   echo "please run by root!!!"; 
   exit;
fi

paramSize=$#
if [[ ! paramSize -eq 1 ]]; then
	echo "please input one param(name) $paramSize"
	exit;
fi
username=$1;
sudoGroupName="sudo";
lookUserName=`cat /etc/shadow | grep $username`

if [[ -n "$lookUserName" ]]; then
	echo "$username is exists!!";
	exit 0;
fi

lookGroup=`cat /etc/group | grep $sudoGroupName`
if [[ ! -n "$lookGroup" ]]; then
	echo "$sudoGroupName user group not exists";
	groupadd $sudoGroupName;
fi
sudo adduser --home /home/$username --shell /usr/bin/zsh $username
sudo usermod -aG $sudoGroupName $username

echo "add $username success!!!"