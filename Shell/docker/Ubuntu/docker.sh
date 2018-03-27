#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). Install docker-ce automatically
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/27 17:20
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


P_LOG=true


source ../../utils/log/log.sh


exec_installment() {
  logger info "Start to download and install docker-ce..."
  apt-get update
  apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
  apt-get update
  apt-get install -y docker-ce
  logger success "Download and install docker-ce completely"
}


main() {
  exec_installment
}


main
