#!/bin/bash

SOURCE_DIR=${1:-lab_uno}
RM_LIST=${2:-2remove}
TARGET_DIR=${3:-bakap}
bakap="${TARGET_DIR}_$(date +%Y-%m-%d).zip"

if [[ ! -e ${TARGET_DIR} ]]; then
    mkdir ${TARGET_DIR}
fi

ITEMS=$(cat ${RM_LIST})

for ITEM in ${ITEMS}; do
# for ITEM in ${RM_LIST}; do
echo "Mamy ${ITEM}"
    if [[ -e "$SOURCE_DIR/$ITEM" ]]; then
        rm -rf -r "$SOURCE_DIR/$ITEM"
    fi
done

for ITEM in ${SOURCE_DIR}/*; do
#    if [[ ! -e ${RM_LIST}/${ITEM} && -f ${ITEM} ]]; then
    if [[ ! -e ${ITEMS} && -f ${ITEM} ]]; then
    mv -f ${ITEM} ${TARGET_DIR}/
    elif [[ ! -e ${ITEMS} && -d ${ITEM} ]]; then
#    elif [[ ! -e ${RM_LIST}/${ITEM} && -d ${ITEM} ]]; then
    mv ${ITEM} ${TARGET_DIR}/
    fi
done

for ITEM in "$SOURCE_DIR/"; do
    COUNTER=$((COUNTER+1))
done

if [[ ${COUNTER} -gt 3 ]]; then
    echo "zostalo wiecej niz 4 pliki"
elif [[ ${COUNTER} -gt 2 ]]; then
    echo "Shrek for life"
else
    echo "zostaly conajmniej 2 pliki"
fi


zip -r "${bakap}" "${TARGET_DIR}"
