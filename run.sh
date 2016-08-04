#!/bin/sh
#shellcheck disable=2086,2089,SC2090

main() {
  if [ ! -e "$WERCKER_BASH_TEMPLATER_TEMPLATE" ]; then
    fail "template not found \"$WERCKER_BASH_TEMPLATER_TEMPLATE\""
  fi

  download

  $WERCKER_BASH_TEMPLATER_PARAMETERS ./templater.sh "$WERCKER_BASH_TEMPLATER_TEMPLATE" > "$WERCKER_BASH_TEMPLATER_OUTPUT"

  rm templater.sh
}

fail() {
  printf "%b%b%b\n" "\e[1;31m" "failed: $1" "\e[m"
  exit 1
}

download() {
  version="$WERCKER_BASH_TEMPLATER_VERSION"
  curl -O --fail --location --silent "https://github.com/axnux/bash-templater/archive/v$version.tar.gz" | tar -xzf bash-templater-$version/templater.sh
  tar -xzf v$version.tar.gz bash-templater-$version/templater.sh
  mv bash-templater-$version/templater.sh ./
  rm -rf bash-templater-$version v$version.tar.gz
    
  chmod +x templater.sh
}

main
