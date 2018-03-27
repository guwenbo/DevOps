#!/bin/bash
#
# **************************************************************************************************
# *                       What does this script do?
# *
# * (1). create directory at /usr/local/tomcat (default) to save tomcat's source if doesn't exist
# * (2). Download Tomcat (default: 8.5.29) and uncompress to the dir
# * (3). configure tomcat (ref: configure/*.sh)
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/25 10:20
# *    Update on:   2018/03/26 09:30
# *
# **************************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


for conf in settings/*.conf
do
    source $conf
done

source ../utils/log/log.sh


deal_dependencies() {
  logger info "Checking for dependencies..."
  if command -v curl > /dev/null ; then
    logger info "Detected curl..."
  else
    logger info "Undetected curl, it will be installed soon..."
    logger info "Installing curl..."
    apt-get install -q -y curl
    if [[ "$?" -ne "0" ]]; then
      logger fatal "Unable to install curl!"
      logger fatal "System aborted!"
      exit 1
    fi
  fi
}


make_dir() {
  # mkdir for tomcat source if doesn't exist
  if [[ ! -d $TOMCAT_SOURCE_LOCATION ]]; then
      logger info "Create directory ${TOMCAT_SOURCE_LOCATION} for saving tomcat's source"
      mkdir -p $TOMCAT_SOURCE_LOCATION
  fi
}


download_and_uncompress() {
  logger info "Start to download ${TOMCAT_TAR_NAME} and uncompress"
  curl  $TOMCAT_SOURCE | tar -xz -f - -C $TOMCAT_SOURCE_LOCATION
  logger info "Download and uncompress completely"
  # modify the structure for target dir
  cp -a $TOMCAT_SOURCE_LOCATION/$TOMCAT_TAR_NAME/* $TOMCAT_SOURCE_LOCATION
  rm -rf $TOMCAT_SOURCE_LOCATION/$TOMCAT_TAR_NAME
}


configure_tomcat() {
  for x in configure/*.sh
  do
    source $x
  done
}


create_autostart_service() {
  # re-import service.conf
  source settings/service.conf
  cat service/tomcat.service > $TOMCAT_SERVICE
  sed -i \
      -e "s#CATALINA_START#$CATALINA_START#g" \
      -e "s#CATALINA_STOP#$CATALINA_STOP#g" \
      $TOMCAT_SERVICE
  systemctl enable tomcat.service
}


prompt() {
    logger success "Congratulations! You've just download ${TOMCAT_TAR_NAME} successfully"
}


main() {
  deal_dependencies
  make_dir
  download_and_uncompress
  configure_tomcat
  create_autostart_service
  prompt
}


main
