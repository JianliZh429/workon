#!/bin/bash

# mapfile -d $'\0' DIR < <(find $HOME/workspace -type d -name "$1" -print0)
# locate *lms-dev | awk '{ print length, $0 }' | sort -n -s | awk '{ print $2 }'
# find $HOME/workspace -type d -name $1
# DIR=()
# while IFS=' '  read -r -d $'\0'; do
#     DIR+=("$REPLY")
# done < <(find $HOME/workspace -type d -name $1)

# WORKSPACE="$HOME/workspace/"

DIR="$WORKSPACE/workon"
echo $DIR
function  find_proj() {
	#DIR_STR=$(locate $HOME/workspace/*$1 -l 3 | awk '{ print length, $0 }' | sort -n -s | awk '{ print $2 }')
	#IFS=' ' read -a DIR <<< "$DIR_STR"

	echo "$DIR_STR"

	echo -e "\nMatched directories are: \n${DIR[@]} \n\nGo to the first as default"

	FIRST_DIR="${DIR[0]}/"

	echo "${FIRST_DIR}"
	cd "${FIRST_DIR}"
}

function call_python_script() {
    if [ -z $1 ]
    then
        cd $WORKSPACE
    else
        SCRIPT="$DIR/workon/workon.py"
        FIRST_DIR=$(python $SCRIPT goto $1)

        echo -e "GOTO work directory: \n$FIRST_DIR"
        if [[ -d $FIRST_DIR ]]; then
            #statements
            cd $FIRST_DIR
        else
            FIRST_DIR=$1
            echo -e "\n$FIRST_DIR is not a valid work drectory"
        fi
    fi
	
}

call_python_script $1

if [[ -d venv ]]; then
	#statements
	source venv/bin/activate
fi
