#!/bin/bash
#
# ******************************************************************************************************
# *                       What does this script do?
# *
# * (1). use user root and group root to own Nginx's resource dir
# * (2). create user nginx and group devops to own Nginx's source dir if doesn't exist
# * (3). use user root and group devops to handle Nginx's binary
# * (4). SetUID for Nginx's binary (default: 4750)
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/28 11:00
# *    Update on:
# *
# ******************************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$NGINX_SOURCE_USER" && -z "$NGINX_SOURCE_GROUP" ]]; then
  # import configuration
  source ../settings/nginx.conf
  source ../settings/permission.conf
  # import log utils
  source ../../utils/log/log.sh
fi


main() {
  # create group devops if doesn't exist
  if [[ -z $(grep $NGINX_SOURCE_GROUP /etc/group) ]]; then
    logger info "Append group $NGINX_SOURCE_GROUP"
    groupadd -r $NGINX_SOURCE_GROUP
  fi

  # create user nginx if doesn't exist
  if [[ -z $(grep $NGINX_SOURCE_USER /etc/passwd) ]]; then
    logger info "Append user $NGINX_SOURCE_USER"
    useradd $NGINX_SOURCE_USER -m -g $NGINX_SOURCE_GROUP -s /bin/bash
  fi

  # chown nginx's resource root
  if [[ -d "${NGINX_RESOURCE_DIR}/${NGINX_TAR_NAME}" ]]; then
    logger info "change $NGINX_RESOURCE_USER:$NGINX_RESOURCE_GROUP to own $NGINX_TAR_NAME"
    chown -R $NGINX_RESOURCE_USER:$NGINX_RESOURCE_GROUP ${NGINX_RESOURCE_DIR}/${NGINX_TAR_NAME}
  fi

  # chown nginx's source root
  if [[ -d $NGINX_PREFIX ]]; then
    logger info "change $NGINX_SOURCE_USER:$NGINX_SOURCE_GROUP to own $NGINX_PREFIX"
    chown -R $NGINX_SOURCE_USER:$NGINX_SOURCE_GROUP $NGINX_PREFIX
    logger info "change $NGINX_BINARY_USER:$NGINX_BINARY_GROUP to own nginx's binary"
    chown $NGINX_BINARY_USER:$NGINX_BINARY_GROUP $NGINX_PREFIX/sbin/nginx
    chmod $NGINX_BINARY_PERMISSION $NGINX_PREFIX/sbin/nginx
  fi
}

main
