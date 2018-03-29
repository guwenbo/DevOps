#!/bin/bash
#
# ************************************************************************************************
# *                       What does this script do?
# *
# * (1). create dir at /usr/local/gitlab for saving docker-compose.yml of gitlab if doesn't exist
# * (2). copy Docker/Compose/gitlab/docker-compose.yml into the dir
# * (3). create gitlab.service and configure automatically
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/29 11:30
# *    Update on:
# *
# ************************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


source settings/service.conf
source ../utils/log/log.sh


make_dir() {
  # mkdir for saving gitlab yaml if doesn't exist
  if [[ ! -d $GITLAB_YAML_LOCATION ]]; then
    logger info "Create directory ${GITLAB_YAML_LOCATION} for saving gitlab yaml"
    mkdir -p $GITLAB_YAML_LOCATION
  fi
}


copy_yaml() {
  logger info "Copy gitlab yaml for docker-compose into $GITLAB_YAML_LOCATION"
  cp ../../Docker/Compose/gitlab/docker-compose.yml $GITLAB_YAML_LOCATION
}


create_autostart_service() {
  cat service/gitlab.service > $GITLAB_SERVICE
  sed -i \
      -e "s#GITLAB_YAML_LOCATION#$GITLAB_YAML_LOCATION#g" \
      -e "s#DOCKER_COMPOSE_BINARY_LOCATION#$DOCKER_COMPOSE_BINARY_LOCATION#g" \
      $GITLAB_SERVICE
  systemctl enable gitlab.service
}


prompt() {
    logger success "Congratulations! You've just create and enable gitlab.service successfully"
}


main() {
  make_dir
  copy_yaml
  create_autostart_service
  prompt
}


main
