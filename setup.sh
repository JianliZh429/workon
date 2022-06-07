#!/bin/bash

if [ -z "${WORKON_HOME}" ]; then
  WORKON_HOME=$(pwd)
fi
echo "WORKON_HOME: ${WORKON_HOME}"

if [[ -z "${WORKON_WORKSPACE}" ]]; then
  WORKON_WORKSPACE="${HOME}"
fi
echo "WORKON_WORKSPACE: ${WORKON_WORKSPACE}"

WORKON_DEPTH=4
echo "WORKON_DEPTH: ${WORKON_DEPTH}"

WORKON_PY="${WORKON_HOME}/workon/workon.py"

echo "export WORKON_HOME=${WORKON_HOME}
export WORKON_WORKSPACE=${WORKON_WORKSPACE}
export WORKON_DEPTH=${WORKON_DEPTH}
alias workon='. ${WORKON_HOME}/workon.sh'
alias workadd='python ${WORKON_PY} assemble'
alias workalias='python ${WORKON_PY} alias'
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