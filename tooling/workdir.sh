#!/usr/bin/bash

declare -A WORK_PATHS=(
  # map list of directories. The key will be the name used on env name of o each item
  # All paths will be relative do $HOME
  # Example line:
  # [NAME]="path/from/home"
)

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

function print_line () {
    printf " +"
    for (( it=1; it<=$1 - 1; it++ ))
    do
        printf "-"
    done
    printf "+\n"
}
function print_instruction () {
    local message_size=${#2}
    local size=$(($1 - $message_size))
    printf " |"
    for (( it=1; it<=$size; it++ ))
    do
        if [[ $it == $(($size / 2)) ]]
            then printf "$2"
        else printf "-"
        fi
    done
    printf "|\n"
}

lines=$(tput lines)
cols=$(($(tput cols) -2 ))

function screen_top () {
    print_line $cols
    print_instruction $cols "Select a context to work on"
    print_line $cols
}
selected=""

function render_options() {
    index=0
    for o in "${!WORK_PATHS[@]}"
    do
        if [[ "$index" == "$cur" ]]
        then
            selected=$o
            echo -e " >\e[7m$o\e[0m" # mark & highlight the current option
        else echo "  $o"
        fi
        index=$(( $index + 1 ))
    done
}

set_paths_env ;

shift
shift
cur=0
count=${#WORK_PATHS[@]}

while true
do
    tput clear ;
    # its worh a lite edition?
    screen_top ;

    render_options ;
    read -s -n 1 key # wait for user to key in arrows or ENTER

    if [[ $key == "w" || $key == "A" ]] # up arrow
    then cur=$(( $cur - 1 ))
        [ "$cur" -lt 0 ] && cur=0
    elif [[ $key == "s" || $key == "B" ]] # down arrow
    then cur=$(( $cur + 1 ))
        [ "$cur" -ge $count ] && cur=$(( $count - 1 ))
    elif [[ $key == "" ]] # nothing, i.e the read delimiter - ENTER
    then break
    fi
done

cd "${HOME}/${WORK_PATHS[$selected]}"

if [[ -f "$NVM_DIR/nvm.sh" ]]
    then source $NVM_DIR/nvm.sh
    else exit "Missing dependence: NVM"
fi

code .

if [[ -f "package.json" ]] #:/
then
    if [[ -f ".nvmrc" ]]
        then echo "using .nvmrc" && nvm use
        else echo "'.nvmrc' not found, using LTS" && nvm use --lts
    fi

    if [[ -d "node_modules" ]]
        then echo "node_modules alredy installed, running dev server"
        else echo "Downloading node_modules..." && npx yarn
    fi

    npx yarn dev

else echo "Not on a node project"
fi
