#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). Download httpd (default 2.4.29) and uncompress it to /usr/local/src
# * (2). Download and uncompress dependencies (apr, apr-util) into
#        /httpd_source_tree_root/srclib without version numbers , such as
#        srclib/apr and srclib/apr-util
# * (3). Install dependencies for httpd like: lib-perl, lib-expat and lib-ssl
# * (4). Make and install httpd with dependencies
# * (5). configure Apache2 (ref: configure/*.sh)
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/29 16:40
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


CURRENT_DIR=$(pwd)


source settings/httpd.conf
source ../utils/log/log.sh


download_httpd_uncompress() {
  logger info "Start to download ${HTTPD_TAR_NAME} and uncompress"
  curl  $HTTPD_RESOURCE | tar -xz -f - -C $HTTPD_RESOURCE_DIR
  logger info "Download and uncompress completely"
}


deal_dependencies() {
  logger info "Installing dependencies for Httpd ..."
  # install httpd's lib dependencies
  apt-get install -y libpcre3-dev libexpat1-dev libssl-dev

  # download and uncompress httpd dependencies
  source settings/apr.conf
  source settings/apr_util.conf
  for x in dependencies/*.sh
  do
    source $x
  done
  logger info "Dependencies installed completely ..."
}


make_install() {
  logger info "Start to make and install Httpd"
  cd ${HTTPD_RESOURCE_DIR}/${HTTPD_TAR_NAME} \
  && ./configure \
     --prefix=${HTTPD_PREFIX}  \
     --with-included-apr \
     --enable-ssl \
  && make -j 10 \
  && make install
  logger success "Make and install Httpd successfully"
}


configure_apache() {
  cd $CURRENT_DIR
  # configure httpd source permission
  source settings/permission.conf
  source configure/permission.sh

  # configure httpd for vhost
  source settings/vhost.conf
  source configure/vhost.sh

  # modify httpd's listen port
  source settings/port.conf
  source configure/port.sh
}


create_autostart_service() {
  # re-import service.conf
  source settings/service.conf
  cat service/httpd.service > $HTTPD_SERVICE
  sed -i \
      -e "s#HTTPD_START#$HTTPD_START#g" \
      -e "s#HTTPD_STOP#$HTTPD_STOP#g" \
      -e "s#HTTPD_RELOAD#$HTTPD_RELOAD#g" \
      $HTTPD_SERVICE
  systemctl enable httpd.service
}


prompt() {
    logger success "Congratulations! You've just download and install ${HTTPD_TAR_NAME} successfully"
}


main() {
  download_httpd_uncompress
  deal_dependencies
  make_install
  configure_apache
  create_autostart_service
  prompt
}


main
