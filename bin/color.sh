#!/bin/bash

for i in {0..255}; do
	# set white background / color text 
	#printf "\x1b[48;2;255;255;255m"
	printf "\x1b[48;5;15m"
	printf "\x1b[38;5;${i}mcolour${i}"

	# set black background / color text 
	printf "\x1b[48;5;0m"
	printf "\x1b[38;5;${i}mcolour${i}"

	# set color background / white text 
	printf "\x1b[48;5;${i}m"
	printf "\x1b[38;5;15mcolour${i}"

	# set color background / black text 
	printf "\x1b[48;5;${i}m"
	printf "\x1b[38;5;0mcolour${i}"

	printf "\x1b[48;5;15m"
	printf "\x1b[38;5;0m\n"
done
	printf "\x1b[48;2;255;255;255m"
	printf "\x1b[38;2;0;0;0m"
