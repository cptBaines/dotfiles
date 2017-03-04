#!/bin/bash

if [[ ! -d /etc/alternatives ]]; then
	return
fi

echo "Get rid of stupid editors like nano, by relinking them to vim"
echo "Processing directory /etc/alternatives ...." 

NANO=$(which nano)
VIM=$(which vim)

while [[ -L ${NANO} ]]; do
	NANO=$(readlink ${NANO})
done

for l in $(find /etc/alternatives -type l); do
	target=$(readlink ${l})
	#echo Target = ${target}
	if [[ "${target}" == "${NANO}" ]]; then 
		echo "=> found link ${l} pointing to ${NANO}"
		echo -n "=> Relinking: " 
		sudo ln -sf -v ${VIM} ${l}
	fi
done

echo "Done"
