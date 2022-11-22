#!/usr/bin/bash
source WORK_PATHS.sh

DIR_LIST_FILE="$TOOLING_DIR/WORK_PATHS.sh"

function set_paths_env() {
  local s='$'
  for KEY in ${!WORK_PATHS[@]}; do
    local value_from_env=$(printenv "$KEY")
        local work_path=${WORK_PATHS[$KEY]}
        if [ "$value_from_env" != "$HOME/$work_path" ]
      then echo "export $KEY=${s}HOME/${WORK_PATHS[$KEY]}" >> "$HOME/.zshrc"
    fi
  done
}

function saveDir() {
  file=$(cat $DIR_LIST_FILE)
  newPath=$2
  newPath="${newPath/$HOME'/'/""}"
  newPath="  [$1]=$newPath\n)"
  printf "${file/)/"$newPath"}" > "$DIR_LIST_FILE"
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

  # set_paths_env
}