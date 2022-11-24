#!/usr/bin/bash
source $TOOLING_DIR/newWorkDir.sh
source $TOOLING_DIR/workdir.sh

if [[ $# < 1 ]]
  then workdir
elif [[ $1 == "--help" || $1 == "-h" || $1 == "--h" ]]
  then
    printf "show comands list\n"
    printf "    [new (TITLE*) (PATH)]:  create new option to work on, default PATH is PWD, now would be $PWD\n"
elif [ $1 == "new" ]
  printf "Creating new folder option"
  then newWorkDir "${@:2}"
fi
