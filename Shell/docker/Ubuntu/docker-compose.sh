#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). Install docker-compose to /usr/local/bin automatically
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/27 18:15
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


P_LOG=true


source ../../utils/log/log.sh


exec_installment() {
  logger info "Start to download and install docker-compose..."
  curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  logger success "Download and install docker-compose completely"
}


main() {
  exec_installment
}


main
