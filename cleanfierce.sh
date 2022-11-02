#!/bin/bash


while getopts l: flag

do

	case "${flag}" in

		l) list=${OPTARG};;

	esac

done


while read dom; do

	fierce --domain $dom >> dirtyfile

done < $list


grep "Found" dirtyfile | cut -d " " -f 2 | sed 's/.$//' >> cleanfile

while true; do
	printf "Do you want to run Gowitness? "
	read yn
	case $yn in
		[Yy]* ) printf "\n Starting screen grab";
			/home/parallels/go/bin/gowitness file -f cleanfile -F;
			printf "\nStarting Gowitness server";
			x-terminal-emulator -e /home/parallels/go/bin/gowitness server;
			break;;
		[Nn]* ) exit;;
		* ) echo "You can't run from me.";;
	esac
done
