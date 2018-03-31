#!/bin/bash
#
# ******************************************************************************************
# *                       What does this script do?
# *
# * (1). Modify httpd's Listen port to 22000
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/31 10:00
# *    Update on:
# *
# ******************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$HTTPD_LISTEN_PORT" ]]; then
  # import configuration
  source ../settings/httpd.conf
  source ../settings/port.conf
  # import log utils
  source ../../utils/log/log.sh
fi


modify_listen_port() {
  logger info "Modify httpd's Listen port to $HTTPD_LISTEN_PORT"
  sed -i "/Listen 80/ c Listen $HTTPD_LISTEN_PORT" ${HTTPD_PREFIX}/conf/httpd.conf
}


main() {
  modify_listen_port
}


main
