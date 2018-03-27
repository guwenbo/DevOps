#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). modify the max size of deploying jar with tomcat from 50MB to 100MB
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/25 12:00
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$MAX_JAR_SIZE" ]]; then
  # import configuration
  source ../settings/tomcat.conf
  source ../settings/max_jar_size.conf
  # import log utils
  source ../../utils/log/log.sh
fi


MAX_JAR_SIZE_CONF=${TOMCAT_SOURCE_LOCATION}/webapps/manager/WEB-INF/web.xml


main() {
  logger info "Modify max jar size from 52428800 to $MAX_JAR_SIZE"
  sed -i "s#52428800#${MAX_JAR_SIZE}#g" $MAX_JAR_SIZE_CONF
}


main
