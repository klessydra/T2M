#!/bin/bash

printERROR(){
	echo -e "\e[31mError\e[0m: Incorrect path"
	echo Usage Example:
	echo -e "\t\e[32m$0 <pulpino path>\e[0m"
}

PATHOK=0
if (( $# == 1  ))
then

	if [ -e $1 ]
	then
		if [ -e "$1/update-ips.py" ]
		then
			echo OK!!!
			KLESS_PATH=$(pwd)
			cd $1
			PULP_PATH=$(pwd)
			cd $KLESS_PATH

			echo "Pulpino: $PULP_PATH"
			echo "Klessydra: $(pwd)"
			PATHOK=1
		else
			printERROR
		fi
	else
		printERROR
	fi
else
	printERROR
fi


if ((PATHOK==1))
then

	export KLESS_PATH
	export PULP_PATH

	# common patched files
	cp -r $KLESS_PATH/klessydra-t2-m $PULP_PATH/ips
	cp -r $KLESS_PATH/patched_files/common_patched_files/sw		$PULP_PATH/
	cp -r $KLESS_PATH/patched_files/common_patched_files/ips	$PULP_PATH/
	cp -r $KLESS_PATH/patched_files/common_patched_files/rtl	$PULP_PATH/
	cp -r $KLESS_PATH/patched_files/common_patched_files/tb		$PULP_PATH/
	cp -r $KLESS_PATH/patched_files/common_patched_files/vsim	$PULP_PATH/

	# S1 patched files
	cp -f $KLESS_PATH/patched_files/t2m_patched_files/cmake_configure.klessydra-t2m.gcc.sh $PULP_PATH/sw
	cp -f $KLESS_PATH/patched_files/t2m_patched_files/vcompile_klessydra-t2m.csh $PULP_PATH/vsim/vcompile

fi

exit
