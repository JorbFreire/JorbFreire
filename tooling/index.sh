#!/usr/bin/bash
source newWorkDir.sh
source workdir.sh

if [[ $# < 1 ]]
  then workdir
elif [[ $1 == "--help" || $1 == "-h" || $1 == "--h" ]]
  then echo "show comands list"
elif [ $1 == "new" ]
  then newWorkDir "${@:2}"
fi
