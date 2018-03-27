#!/bin/bash
#
# *****************************************************************************************
# *                       What does this script do?
# *
# * (1). create directory at /usr/local/jenkins/logs to save jenkins' logs if doesn't exist
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/26 10:45
# *    Update on:
# *
# *****************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$JENKINS_LOG_DIR" ]]; then
  # import configuration
  source ../settings/jenkins.conf
  source ../settings/jenkins_logs.conf
  # import log utils
  source ../../utils/log/log.sh
fi


main() {
  # create dir for saving jenkins' log if doesn't exist
  if [[ ! -d $JENKINS_LOG_DIR ]]; then
    logger info  "Create directory ${JENKINS_LOG_DIR}"
    mkdir -p $JENKINS_LOG_DIR
  fi
}


main
