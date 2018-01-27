#!/bin/bash
#
#	userctr.sh 操作（add或者del）教师名 学生名前缀 学生数量
#
if [[  "$#" != 4 ]]; then
	echo "param size illegal"
	echo -e "用法:\n userctrl opration teacherName studentPrefix studentSize"
	exit
fi

opration=$1
teacherName=$2
studentPrefix=$3
studentSize=$4

if [[ -n "$(echo $4 | sed -n "/^[0-9]\{1,2\}$/p")"  ]]; then
		if [[ $4 -gt 10 ]]; then
			echo "parameter error"
			exit;
		fi
else
	echo "parameter error"
	exit;
fi

if [[ "$opration" = "add" ]]; then
	sudo adduser --home /home/$teacherName --shell /bin/bash $teacherName >  /dev/null 2>&1

	while [[ studentSize -gt 0 ]]; do
			studentName=$studentPrefix$studentSize
		sudo adduser --home /home/$studentName --shell /bin/bash $studentName > /dev/null 2>&1
			if [ $? -eq 0 ];then
				# 6位随机数字为密码
				password=`head /dev/urandom | tr -dc 0-9 | head -c 6`;
				echo "$password" | passwd --stdin $studentName > /dev/null 2>&1;
				echo "$studentName $password"
			else
				echo "$studentName ******"	
			fi	
		 	let studentSize=studentSize-1
	done

elif [[ "$opration" -eq "delete" ]]; then
	 userdel $teacherName  > /dev/null 2>&1
	 while [[ studentSize -gt 0 ]]; do
	 	studentName=$studentPrefix$studentSize
	 	userdel $studentName  > /dev/null 2>&1
	 	let studentSize=studentSize-1
	 done	
else
	echo "parameter error"
	exit;
fi

