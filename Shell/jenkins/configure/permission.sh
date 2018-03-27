#!/bin/bash
#
# ***************************************************************************************
# *                       What does this script do?
# *
# * (1). create user jenkins and group devops to own jenkins' source dir if doesn't exist
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/26 10:30
# *    Update on:
# *
# ***************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$JENKINS_USER" && -z "$JENKINS_GROUP" ]]; then
  # import configuration
  source ../settings/jenkins.conf
  source ../settings/permission.conf
  # import log utils
  source ../../utils/log/log.sh
fi


main() {
  # create group devops if doesn't exist
  if [[ -z $(grep $JENKINS_GROUP /etc/group) ]]; then
    logger info "Append group $JENKINS_GROUP"
    groupadd -r $JENKINS_GROUP
  fi
  # create user jenkins if doesn't exist
  if [[ -z $(grep $JENKINS_USER /etc/passwd) ]]; then
    logger info "Append user $JENKINS_USER"
    useradd $JENKINS_USER -m -g $JENKINS_GROUP -s /bin/bash
  fi
  # chown jenkins' source root
  if [[ -d $JENKINS_PARENT_DIR ]]; then
    logger info "change $JENKINS_USER:$JENKINS_GROUP to own $JENKINS_PARENT_DIR"
    chown -R $JENKINS_USER:$JENKINS_GROUP $JENKINS_PARENT_DIR
  fi
}

main
