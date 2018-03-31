#!/bin/bash
#
# ******************************************************************************************
# *                       What does this script do?
# *
# * (1). create directory at $HTTPD_PREFIX/conf/vhost to handle vhost's configuration
# * (2). append the vhost directory to httpd.conf
# * (3). touch a test file under $HTTPD_PREFIX/conf/vhost due to httpd configuration check
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/30 23:00
# *    Update on:
# *
# ******************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$HTTPD_VHOST_LOCATION" ]]; then
  # import configuration
  source ../settings/httpd.conf
  source ../settings/vhost.conf
  # import log utils
  source ../../utils/log/log.sh
fi


make_dir() {
  logger info "Create directory ${HTTPD_VHOST_LOCATION} for handling vhost's configuration"
  mkdir -p $HTTPD_VHOST_LOCATION
}


append_httpd_conf() {
  logger info "append the vhost directory to httpd.conf"
  sed -i '/# Virtual hosts/ a Include conf/vhost/*.conf' $HTTPD_CONF_LOCATION
}


touch_test_conf_file() {
  logger info "touch a test file for httpd vhost configuration"
  echo -e "#This is a test config file for http, just for pass httpd's configure check\n#You can remove this file when you have good choice."> $HTTPD_VHOST_LOCATION/test.conf
}


main() {
  make_dir
  append_httpd_conf
  touch_test_conf_file
}


main
