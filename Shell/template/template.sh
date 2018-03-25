#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1).
# *
# *
# *
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


P_LOG=true

logger() {
    if [[ $P_LOG != true ]]; then
      return
    fi
    case "$1" in
      info)
        echo -e "\x1b[34;1m${2}\x1b[0;0m"
        ;;
      success)
        echo -e "\x1b[32;1m${2}\x1b[0;0m"
        ;;
      warn)
        echo -e "\x1b[33;6m${2}\x1b[0;0m"
        ;;
      error)
        echo -e "\x1b[31;1m${2}\x1b[0;0m"
        ;;
      fatal)
        echo -e "\x1b[31;7m${2}\x1b[0;0m"
        ;;
      *)
        echo "$1 $2"
        ;;
    esac
}


main() {
  logger info "test"
  logger success "test"
  logger warn "test"
  logger error "test"
  logger fatal "test"
}


main
