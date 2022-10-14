#! /bin/bash

source ${RNST_ROOT_DIR}/scripts/util.sh

assert_arg_count 1 $#

cd ${RNST_ROOT_DIR}/$1

rm -fr node_modules android/build android/app/build ios/Pods ios/build
