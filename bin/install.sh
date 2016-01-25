#!/bin/bash

mydotfiles=${0%/bin/*}
dirs=( bash git system tmux vim )

# this file must install any of the files in bin
# do this here

# For each directory call its isntall.sh to do their stuff
for d in ${dirs[@]}; do
	if [[ -x ${mydotfiles}/${d}/install.sh ]]; then
		echo ${mydotfiles}/${d}/install.sh
		${mydotfiles}/${d}/install.sh
	else
		echo "Not implemented: ${mydotfiles}/${d}/install.sh" 
	fi
done
