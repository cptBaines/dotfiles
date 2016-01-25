#!/bin/bash


function install_link()
{
	local file=$1
	echo ${file}
	if [[ (-f ${file}) && (! -f ${file}.orig) ]]; then
		echo backup file ${file}
		mv ${file} ${file}.orig 

	else
		echo ${file} already backed.
	fi	
}


if [[ -L ~/.bashrc ]]; then
	echo ~/.bashrc is a link
else
	install_link ~/.bashrc
	echo "doing my stuf"
fi
