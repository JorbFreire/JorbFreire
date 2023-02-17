#!/usr/bin/bash
source $TOOLING_DIR/WORK_PATHS.sh

DIR_LIST_FILE="$TOOLING_DIR/WORK_PATHS.sh"
DIR_LIST_INDEX_FILE="$TOOLING_DIR/WORK_PATHS_INDEX.sh"

function saveDir() {
  file=$(cat $DIR_LIST_FILE)
  newPath=$2
  newPath="${newPath/$HOME'/'/""}"
  newPath="  [$1]=$newPath\n)"

  printf "${file/)/"$newPath"}" > "$DIR_LIST_FILE"

  file=$(cat $DIR_LIST_INDEX_FILE)
  newPathIndex="  [$1]=${#WORK_PATHS[@]}\n)"
  printf "${file/)/"$newPathIndex"}" > "$DIR_LIST_INDEX_FILE"
}

function newWorkDir() {
  if [[ $# < 1 ]]
    then
      echo "Error: least 1 argument required"
      echo "Expected usage:"
      echo "    new {DIR NAME/TITLE} {PATH (optional)}"
      echo "    default path is PWD (now would be $PWD)"
      exit 0
  fi

  if [ "$2" ]
    then saveDir $1 $2
  else
    saveDir $1 $PWD
  fi
  echo "$WORK_PATHS"
}
