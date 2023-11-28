#! /bin/bash

source ${RNST_ROOT_DIR}/scripts/util.sh
source ${RNST_ROOT_DIR}/scripts/log4bash.sh

declare -i VERBOSE=0

project_name=""

while getopts ":vp:" option; do
  case $option in
    v) # verbose mode
      VERBOSE=0
      echo "Running in verbose mode"
      ;;
    p)
      project_name=${OPTARG}
      ;;
    esac
done

shift $((OPTIND-1))

if [[ -z "$project_name" ]]; then
  log_error "Project name must be specified: -p option"
  exit 1
fi

[ ${VERBOSE} -eq 0 ] && log_info "Stripping project ${project_name}"

assert_dir_exists ${project_name}

cd ${project_name}

[ ${VERBOSE} -eq 0 ] && log_info "removing node_modules, android/build/, android/app/build/, ios/Pods, ios/build"
rm -fr node_modules android/build android/app/build ios/Pods ios/build

cd ${RNST_ROOT_DIR}
