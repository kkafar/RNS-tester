#! /bin/bash

# $1 - Expected
# $2 - actual
assert_arg_count() {
  if [[ ! $# -eq 2 ]]; then
    echo "Error: invalid number of arguments passed to assert function. Expected 2. Received: $#." >&2
    exit 1
  fi

  if [[ ! $1 -eq $2 ]]; then
    echo "Error: invalid number of arguments passed. Expected $1. Received: $2." >&2
    exit 1
  fi
}

# $1 - first value
# $2 - second value
assert_eq() {
  assert_arg_count 2 $#

  if [[ ! $1 == $2 ]]; then 
    echo "Error: assertion failed: $1 != $2" >&2
    exit 1
  fi
}


# $1 - command that should exist
assert_cmd_exists() {
  assert_arg_count 1 $#
  if ! [ -x "$(command -v $1)" ]; then
    echo "Error: $1 is not installed." >&2
    exit 1
  fi
}

# $1 - directory path
assert_dir_exists() {
  assert_arg_count 1 $#
  if [[ ! -d "$1" ]]; then
    echo "Error: $1 is not a directory" >&2
    exit 1
  fi
}
