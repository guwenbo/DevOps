#!/bin/bash
#
# **************************************************************************************************
# *                       What does this script do?
# *
# * (1). create directory at /usr/local/jenkins/src (default) to save jenkins' source if doesn't exist
# * (2). Download Jenkins.war (default: 2.107.1) to the dir
# * (3). configure jenkins (ref: configure/*.sh)
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/26 10:25
# *    Update on:
# *
# **************************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


for conf in settings/*.conf
do
    source $conf
done

source ../utils/log/log.sh


make_dir() {
  # mkdir for jenkins' source if doesn't exist
  if [[ ! -d $JENKINS_SOURCE_LOCATION ]]; then
      logger info "Create directory ${JENKINS_SOURCE_LOCATION} for saving jenkins' source"
      mkdir -p $JENKINS_SOURCE_LOCATION
  fi
}


download() {
  logger info "Start to download jenkins-$JENKINS_VERSION"
  wget $JENKINS_SOURCE -P $JENKINS_SOURCE_LOCATION
  logger info "Download completely"
}


configure_jenkins() {
  source configure/config_execution.sh
  source configure/config_logs.sh
  source configure/permission.sh
}


create_autostart_service() {
  # re-import service.conf
  source settings/service.conf
  cat service/jenkins.service > $JENKINS_SERVICE
  sed -i \
      -e "s#JENKINS_START#$JENKINS_START#g" \
      $JENKINS_SERVICE
  systemctl enable jenkins.service
}


prompt() {
    logger success "Congratulations! You've just download jenkins-${JENKINS_VERSION} successfully"
}


main() {
  make_dir
  download
  configure_jenkins
  create_autostart_service
  prompt
}


main
