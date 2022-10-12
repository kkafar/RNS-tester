#! /bin/bash

source ${RNST_ROOT_DIR}/scripts/util.sh

__ret_val__=''

# $1 - app name
# $2 - RN version
create_rns_app() {
  assert_arg_count 2 $#

  cd ${RNST_ROOT_DIR}

  npx react-native init "$1" --version "$2"
  yarn add react-native-screens
  yarn add react-native-safe-area-context
  yarn add @react-navigation/native-stack
  yarn add @react-navigation/native

  cp "${RNST_ROOT_DIR}/scripts/App.template.js" "${RNST_ROOT_DIR}/$1/App.js"
}

assert_cmd_exists "npx"
assert_cmd_exists "yarn"

# $1 - app name
# $2 - RN version
assert_arg_count 2 $#
