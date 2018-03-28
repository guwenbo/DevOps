#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). Install dependencies for Nginx like: perl, zlib and libssl, etc
# * (2). Download Nginx (default: 1.10.1) and uncompress to /usr/local/src
# * (2). Make and install Nginx to /usr/local/nginx
# * (3). configure Nginx (ref: configure/*.sh)
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/28 10:10
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


CURRENT_DIR=$(pwd)


for conf in settings/*.conf
do
    source $conf
done

source ../utils/log/log.sh


deal_dependencies() {
  logger info "Installing dependencies for Nginx ..."
  apt-get install -y curl libpcre3-dev zlib1g-dev libssl-dev
  logger info "Dependencies installed completely ..."
}


download_and_uncompress() {
  logger info "Start to download ${NGINX_TAR_NAME} and uncompress"
  curl  $NGINX_RESOURCE | tar -xz -f - -C $NGINX_RESOURCE_DIR
  logger info "Download and uncompress completely"
}


make_install() {
  logger info "Start to make and install Nginx"
  cd ${NGINX_RESOURCE_DIR}/${NGINX_TAR_NAME} \
  && ./configure \
     --prefix=${NGINX_PREFIX}  \
     --with-http_ssl_module \
  && make -j 10 \
  && make install
  logger success "Make and install Nginx successfully"
}


configure_nginx() {
  cd $CURRENT_DIR
  source configure/vhost.sh
  source configure/permission.sh
}


create_autostart_service() {
  # re-import service.conf
  source settings/service.conf
  cat service/nginx.service > $NGINX_SERVICE
  sed -i \
      -e "s#NGINX_START#$NGINX_START#g" \
      -e "s#NGINX_STOP#$NGINX_STOP#g" \
      -e "s#NGINX_RELOAD#$NGINX_RELOAD#g" \
      $NGINX_SERVICE
  systemctl enable nginx.service
}


prompt() {
    logger success "Congratulations! You've just download and install ${NGINX_TAR_NAME} successfully"
}


main() {
  deal_dependencies
  download_and_uncompress
  make_install
  configure_nginx
  create_autostart_service
  prompt
}


main
