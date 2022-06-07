#!/bin/bash

if [ -z "${WORKON_HOME}" ]; then
  WORKON_HOME=$(pwd)
fi

echo "WORKON_HOME is ${WORKON_HOME}"
if [[ -z "${WORKON_WORKSPACE}" ]]; then
  WORKON_WORKSPACE="${HOME}"
fi
echo "WORKON_WORKSPACE is ${WORKON_WORKSPACE}"

PY_WORKON="${WORKON_HOME}/workon/workon.py"

echo "export WORKON_HOME=${WORKON_HOME}
export WORKON_WORKSPACE=${WORKON_WORKSPACE}
alias workon='. ${WORKON_HOME}/workon.sh'
alias workadd='python ${PY_WORKON} assemble'
alias workalias='python ${PY_WORKON} alias'
" > "./workonrc"

WORKONRC="${WORKON_HOME}/workonrc"
if [[ -f "${HOME}/.zshrc" ]]; then
  BASHRC="${HOME}/.zshrc"
elif [ -f "${HOME}/.bashrc" ]; then
  BASHRC="${HOME}/.bashrc"
elif [ -f "${HOME}/.bash_profile" ]; then
  BASHRC="${HOME}/.bash_profile"
fi

if [[ -n "${BASHRC}" ]]; then
  source ./workonrc
  SOURCE_WORKONRC="source ${WORKONRC}"
  if ! grep -q "${SOURCE_WORKONRC}" "${BASHRC}"; then
    echo "${SOURCE_WORKONRC}" >> "${BASHRC}"
  fi
fi