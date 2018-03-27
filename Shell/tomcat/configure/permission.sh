#!/bin/bash
#
# ***************************************************************************************
# *                       What does this script do?
# *
# * (1). create user tomcat and group devops to own tomcat's source dir if doesn't exist
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/25 11:00
# *    Update on:
# *
# ***************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$TOMCAT_USER" && -z "$TOMCAT_GROUP" ]]; then
  # import configuration
  source ../settings/tomcat.conf
  source ../settings/permission.conf
  # import log utils
  source ../../utils/log/log.sh
fi


main() {
  # create group devops if doesn't exist
  if [[ -z $(grep $TOMCAT_GROUP /etc/group) ]]; then
    logger info "Append group $TOMCAT_GROUP"
    groupadd -r $TOMCAT_GROUP
  fi
  # create user tomcat if doesn't exist
  if [[ -z $(grep $TOMCAT_USER /etc/passwd) ]]; then
    logger info "Append user $TOMCAT_USER"
    useradd $TOMCAT_USER -m -g $TOMCAT_GROUP -s /bin/bash
  fi
  # chown tomcat's source root
  if [[ -d $TOMCAT_SOURCE_LOCATION ]]; then
    logger info "change $TOMCAT_USER:$TOMCAT_GROUP to own $TOMCAT_SOURCE_LOCATION"
    chown -R $TOMCAT_USER:$TOMCAT_GROUP $TOMCAT_SOURCE_LOCATION
  fi
}

main
