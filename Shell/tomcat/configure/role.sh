#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). initiaize a super user for tomcat
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/25 11:30
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$SUPER_USER_NAME" && -z "$SUPER_USER_PASSWD" ]]; then
  # import configuration
  source ../settings/tomcat.conf
  source ../settings/role.conf
  # import log utils
  source ../../utils/log/log.sh
fi


TOMCAT_USER_CONFIG_FILE=${TOMCAT_SOURCE_LOCATION}/conf/tomcat-users.xml


main() {
  logger info "Append super user ${SUPER_USER_NAME} for tomcat"
  sed -i \
      -e '$i\ \ <role rolename="manager-gui"/>' \
      -e '$i\ \ <role rolename="admin-gui"/>' \
      -e "\$i\ \ <user username=\"${SUPER_USER_NAME}\" password=\"${SUPER_USER_PASSWD}\" roles=\"manager-gui,admin-gui\"/>" \
      $TOMCAT_USER_CONFIG_FILE
}


main
