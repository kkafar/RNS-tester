#! /bin/bash

source ${RNST_ROOT_DIR}/scripts/util.sh
source ${RNST_ROOT_DIR}/scripts/log4bash.sh

__ret_val__=''

# $1 - app name
# $2 - RN version
create_rns_app() {
  assert_arg_count 2 $#

  cd ${RNST_ROOT_DIR}

  log_info "Creating RN app $1 with version $2"
  npx react-native@latest init "$1" --version "$2"

  cd "${RNST_ROOT_DIR}/$1"

  log_info "Installing deps..."
  yarn add react-native-screens
  yarn add react-native-safe-area-context
  yarn add @react-navigation/native-stack
  yarn add @react-navigation/native

  log_info "Copying template App.js from ${RNST_ROOT_DIR}/scripts/App.template.js"
  cp "${RNST_ROOT_DIR}/scripts/App.template.js" "${RNST_ROOT_DIR}/$1/App.js"
  
  cd ${RNST_ROOT_DIR}
}

assert_cmd_exists "npx"
assert_cmd_exists "yarn"

# $1 - app name
# $2 - RN version
assert_arg_count 2 $#

create_rns_app $1 $2

