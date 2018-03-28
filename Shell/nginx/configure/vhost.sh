#!/bin/bash
#
# **************************************************************************************
# *                       What does this script do?
# *
# * (1). create directory at $NGINX_PREFIX/conf/vhost to handle vhost's configuration
# * (2). append the vhost directory to nginx.conf
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/28 14:40
# *    Update on:
# *
# **************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$NGINX_VHOST_LOCATION" ]]; then
  # import configuration
  source ../settings/nginx.conf
  source ../settings/vhost.conf
  # import log utils
  source ../../utils/log/log.sh
fi


make_dir() {
  logger info "Create directory ${NGINX_VHOST_LOCATION} for handling vhost's configuration"
  mkdir -p $NGINX_VHOST_LOCATION
}


append_nginx_conf() {
  logger info "append the vhost directory to nginx.conf"
  sed -i '/http {/ a \ \ \ \ include\tvhost/*.conf;' $NGINX_CONF_LOCATION
}


main() {
  make_dir
  append_nginx_conf
}


main
