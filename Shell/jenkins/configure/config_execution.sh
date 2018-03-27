#!/bin/bash
#
# ***********************************************************************************************
# *                       What does this script do?
# *
# * (1). create directory at /usr/local/jenkins/bin to save jenkins' execution if doesn't exist
# * (2). copy ../execute/jenkins to the dir
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/26 10:50
# *    Update on:
# *
# ***********************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$JENKINS_EXEC_LOCATION" ]]; then
  ACTIVE_EXEC=true
  # import configuration
  source ../settings/jenkins.conf
  source ../settings/jenkins_execution.conf
  # import log utils
  source ../../utils/log/log.sh
fi


make_dir() {
  # mkdir for execution if doesn't exist
  if [[ ! -d $JENKINS_EXEC_LOCATION ]];then
    logger info "Create directory ${JENKINS_EXEC_LOCATION}"
    mkdir -p $JENKINS_EXEC_LOCATION
  fi
}


copy_exec_to_dir() {
  logger info "Copy execution for launching Jenkins to $JENKINS_EXEC_LOCATION"
  if [[ "$ACTIVE_EXEC" == "true" ]]; then
    cp ../execute/jenkins $JENKINS_EXEC_LOCATION
  else
    cp execute/jenkins $JENKINS_EXEC_LOCATION
  fi
}


main() {
  make_dir
  copy_exec_to_dir
}


main
