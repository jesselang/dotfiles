#!/bin/sh

SCRIPT_NAME=$(basename ${0})
SCRIPT_DIR=$(dirname $PWD/$(dirname ${0}))

for FILE in ${SCRIPT_DIR}/*; do
  FILE=$(basename ${FILE})

  if [ ${FILE} != ${SCRIPT_NAME} ] \
      && [ ${FILE} != README.md ] \
      && [ ! -e "${HOME}/.${FILE}" ];
  then
    echo ln -snf "${SCRIPT_DIR}/${FILE}" "${HOME}/.${FILE}"
    ln -snf "${SCRIPT_DIR}/${FILE}" "${HOME}/.${FILE}"
  fi
done
