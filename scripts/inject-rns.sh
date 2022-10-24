#! /bin/bash

source ${RNST_ROOT_DIR}/scripts/util.sh
source ${RNST_ROOT_DIR}/scripts/log4bash.sh

usage() {
  echo "Inject react-native-screens library into test projects."
  echo "Available options:"
  echo "h   print this help message and exit"
  echo "v   activate verbose mode (recommended)"
  echo "i   run yarn install in project directory before injecting the react-native-screens library"
  echo "g   install react-native-screens directly from GitHub" 
}

declare -i VERBOSE=0
declare -r RNS_REPO_PATH=${RNS_PATH}
declare -i RUN_YARN=1
declare -i INSTALL_FROM_GITHUB=1

# It is important that package name is not prefixed with "rn",
# because we use this prefix to name projects and then recognize them by it.
declare -r PACKAGE_NAME="react-native-screens.tgz"


while getopts ":vihg" option; do
  case $option in
    h) # print help message
      usage
      ;;
    v) # verbose mode
      VERBOSE=0
      log_info "Running in verbose mode"
      ;;
    i) # run yarn install
      RUN_YARN=0
      log_info "Running yarn install after copying"
      ;;
    g) # install from github
      INSTALL_FROM_GITHUB=0
      log_info "react-native-screens will be installed directly from GitHub."
      # TODO
      ;;
    esac
done

shift $((OPTIND-1))

if [[ -z ${RNS_REPO_PATH} ]]; then
  log_error "failed to read RNS_PATH env var"
  exit 1
fi

if [[ ! -d ${RNS_REPO_PATH} ]]; then
  log_error "${RNS_REPO_PATH} is not a directory"
  exit 1
fi

package_file=$(find . -maxdepth 1 -iname "${PACKAGE_NAME}")

if [[ -z ${package_file} ]]; then
  [ ${VERBOSE} -eq 0 ] && log_warning "Did not found package in ${RNST_ROOT_DIR}. Creating package."
  [ ${VERBOSE} -eq 0 ] && log_info "Running yarn prepare in ${RNS_REPO_PATH}"

  cd ${RNS_REPO_PATH}

  yarn prepare

  if [[ $? -ne 0 ]]; then 
    log_error "yarn prepare failed"
    exit 1
  fi

  [ ${VERBOSE} -eq 0 ] && log_info "Running npm pack in ${RNS_REPO_PATH}"
  npm pack

  [ ${VERBOSE} -eq 0 ] && log_info "Looking for package in ${RNS_REPO_PATH}"
  package_file=$(find . -maxdepth 1 -iname "react-native-screens-*.tgz")

  if [[ $? -ne 0 ]]; then 
    log_error "Failed to find library package in ${RNS_REPO_PATH}"
    exit 1
  fi

  [ ${VERBOSE} -eq 0 ] && log_info "Library package found: ${package_file}"
  [ ${VERBOSE} -eq 0 ] && log_info "Moving the package to ${RNST_ROOT_DIR}"
  mv ${package_file} ${RNST_ROOT_DIR}/${PACKAGE_NAME}

  [ ${VERBOSE} -eq 0 ] && log_info "Changing wd to ${RNST_ROOT_DIR}"
else
  [ ${VERBOSE} -eq 0 ] && log_info "Using library package found in ${RNST_ROOT_DIR}: ${package_file}"
fi


cd ${RNST_ROOT_DIR}

package_file=${PACKAGE_NAME}

[ ${VERBOSE} -eq 0 ] && log_info "Unpacking"
tar zxf ${PACKAGE_NAME}

projects=$(ls | grep -E "rn.*")
for project in ${projects}; do
  [ ${VERBOSE} -eq 0 ] && log_info "Processing ${project}"

  if [[ ${RUN_YARN} -eq 0 ]] || [[ ! -d "${RNST_ROOT_DIR}/${project}/node_modules" ]] ; then 
    [ ${VERBOSE} -eq 0 ] && log_info "Running yarn install in ${project}"
    cd ${RNST_ROOT_DIR}/${project} && yarn install && cd ..
  fi

  [ ${VERBOSE} -eq 0 ] && log_info "Injecting react-native-screens"
  rm -fr "${RNST_ROOT_DIR}/${project}/node_modules/react-native-screens" 
  cp -R "package" "${RNST_ROOT_DIR}/${project}/node_modules/react-native-screens"
done



cd ${RNST_ROOT_DIR}
