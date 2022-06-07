#!/bin/bash

# mapfile -d $'\0' WORKON_HOME < <(find $HOME/workspace -type d -name "$1" -print0)
# locate *lms-dev | awk '{ print length, $0 }' | sort -n -s | awk '{ print $2 }'
# find $HOME/workspace -type d -name $1
# WORKON_HOME=()
# while IFS=' '  read -r -d $'\0'; do
#     WORKON_HOME+=("$REPLY")
# done < <(find $HOME/workspace -type d -name $1)

function find_proj() {
  #DIR_STR=$(locate $HOME/workspace/*$1 -l 3 | awk '{ print length, $0 }' | sort -n -s | awk '{ print $2 }')
  #IFS=' ' read -a WORKON_HOME <<< "$DIR_STR"
  #echo "$DIR_STR"

  # shellcheck disable=SC2145
  echo -e "\nMatched directories are: \n${WORKON_HOME[@]} \n\nGo to the first as default"

  FIRST_DIR="${WORKON_HOME[0]}/"

  echo "${FIRST_DIR}"
  # shellcheck disable=SC2164
  cd "${FIRST_DIR}"
}

function call_python_script() {
  if [ -z "$1" ]; then
    # shellcheck disable=SC2164
    cd "$WORKON_WORKSPACE"
  else
    SCRIPT="$WORKON_HOME/workon/workon.py"
    FIRST_DIR=$(python "$SCRIPT" goto "$1")

    echo -e "GOTO work directory: \n$FIRST_DIR"
    if [[ -d $FIRST_DIR ]]; then
      # shellcheck disable=SC2164
      cd "$FIRST_DIR"
    else
      FIRST_DIR=$1
      echo -e "\n$FIRST_DIR is not a valid work directory"
    fi
  fi

}

call_python_script "$1"

if [[ -d venv ]]; then
  #statements
  source venv/bin/activate
fi
