#!/bin/bash
#
# ******************************************************************************
# *                       What does this script do?
# *
# * (1). Download mod_wsgi (default 4.6.2) and uncompress it to /usr/local/src
# * (2). Install dependencies for mod_wsgi like: libpython3.5-dev
# * (3). Make and install mod_wsgi with dependencies
# * (4). Modify http.conf to enable mod_wsgi
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/31 10:50
# *    Update on:
# *
# ******************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$WSGI_RELEASE_VERSION" ]]; then
  # import configuration
  source settings/wsgi.conf
  source ../../settings/httpd.conf
  # import log utils
  source ../../../utils/log/log.sh
fi


deal_dependencies() {
  logger info "Installing dependencies for mod_wsgi ..."
  apt-get install -y curl libpython3.5-dev
  logger info "Dependencies installed completely ..."
}


download_and_uncompress() {
  logger info "Start to download ${WSGI_TAR_NAME} and uncompress"
  curl -L ${WSGI_RESOURCE} | tar -zx -f - -C $WSGI_RESOURCE_DIR
  logger info "Download and uncompress completely"
}


make_install() {
  logger info "Start to make and install mod_wsgi"
  cd ${WSGI_RESOURCE_DIR}/${WSGI_TAR_NAME} \
  && ./configure \
     --with-apxs=${HTTPD_PREFIX}/bin/apxs \
     --with-python=/usr/bin/python3 \
  && make -j 10 \
  && make install
  logger success "Make and install mod_wsgi successfully"
}


modify_http_conf() {
  logger info "enable wsgi_module for httpd.conf"
  sed -i "/<IfModule unixd_module>/ i LoadModule wsgi_module modules/mod_wsgi.so" ${HTTPD_PREFIX}/conf/httpd.conf
}


prompt() {
  logger success "Congratulations! You've installed ${WSGI_TAR_NAME}"
}


main() {
  deal_dependencies
  download_and_uncompress
  make_install
  modify_http_conf
  prompt
}

main
