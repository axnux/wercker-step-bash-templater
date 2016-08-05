#!/bin/sh
#shellcheck disable=2086,2089,SC2090

main() {
  if [ ! -e "$WERCKER_BASH_TEMPLATER_TEMPLATE" ]; then
    fail "template not found \"$WERCKER_BASH_TEMPLATER_TEMPLATE\""
  fi

  download

  export $WERCKER_BASH_TEMPLATER_PARAMETERS
  "$WERCKER_SOURCE_DIR/templater.sh" "$WERCKER_BASH_TEMPLATER_TEMPLATE" > "$WERCKER_BASH_TEMPLATER_OUTPUT"

  rm "$WERCKER_SOURCE_DIR/templater.sh"
}

fail() {
  printf "%b%b%b\n" "\e[1;31m" "failed: $1" "\e[m"
  exit 1
}

download() {
  version="$WERCKER_BASH_TEMPLATER_VERSION"
  curl -O --fail --location --silent "https://github.com/axnux/bash-templater/archive/v$version.tar.gz"
  tar -xzf "v$version.tar.gz" "bash-templater-$version/templater.sh"
  mv "bash-templater-$version/templater.sh" "$WERCKER_SOURCE_DIR"
  rm -rf "bash-templater-$version" "v$version.tar.gz"

  chmod +x "$WERCKER_SOURCE_DIR/templater.sh"
}

main
