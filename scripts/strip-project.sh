#! /bin/bash

source ${RNST_ROOT_DIR}/scripts/util.sh
source ${RNST_ROOT_DIR}/log4bash.sh

declare -i VERBOSE=0

while getopts ":v" option; do
  case $option in
    v) # verbose mode
      VERBOSE=0
      echo "Running in verbose mode"
      ;;
    esac
done

shift $((OPTIND-1))

project_dir="${RNST_ROOT_DIR}/$1"

[ ${VERBOSE} -eq 0 ] && log_info "Stripping project ${project_dir}"

assert_dir_exists ${project_dir}

cd ${project_dir}

[ ${VERBOSE} -eq 0 ] && log_info "removing node_modules, android/build/, android/app/build/, ios/Pods, ios/build"
rm -fr node_modules android/build android/app/build ios/Pods ios/build

cd ${RNST_ROOT_DIR}
