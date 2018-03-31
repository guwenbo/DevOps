#!/bin/bash
#
# ******************************************************************************************************
# *                       What does this script do?
# *
# * (1). use user root and group devops to own httpd's resource dir
# * (2). create user apache and group devops to own httpd's source dir if doesn't exist
# * (3). use user root and group devops to handle Httpd's binary
# * (4). SetUID for Httpd's binary (default: 4750)
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/30 22:45
# *    Update on:
# *
# ******************************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z "$HTTPD_SOURCE_USER" && -z "$HTTPD_SOURCE_GROUP" ]]; then
  # import configuration
  source ../settings/httpd.conf
  source ../settings/permission.conf
  # import log utils
  source ../../utils/log/log.sh
fi


main() {
  # create group devops if doesn't exist
  if [[ -z $(grep $HTTPD_SOURCE_GROUP /etc/group) ]]; then
    logger info "Append group $HTTPD_SOURCE_GROUP"
    groupadd -r $HTTPD_SOURCE_GROUP
  fi

  # create user httpd if doesn't exist
  if [[ -z $(grep $HTTPD_SOURCE_USER /etc/passwd) ]]; then
    logger info "Append user $HTTPD_SOURCE_USER"
    useradd $HTTPD_SOURCE_USER -m -g $HTTPD_SOURCE_GROUP -s /bin/bash
  fi

  # chown httpd's resource root
  if [[ -d "${HTTPD_RESOURCE_DIR}/${HTTPD_TAR_NAME}" ]]; then
    logger info "change $HTTPD_RESOURCE_USER:$HTTPD_RESOURCE_GROUP to own $HTTPD_TAR_NAME"
    chown -R $HTTPD_RESOURCE_USER:$HTTPD_RESOURCE_GROUP ${HTTPD_RESOURCE_DIR}/${HTTPD_TAR_NAME}
  fi

  # chown httpd's source root
  if [[ -d $HTTPD_PREFIX ]]; then
    logger info "change $HTTPD_SOURCE_USER:$HTTPD_SOURCE_GROUP to own $HTTPD_PREFIX"
    chown -R $HTTPD_SOURCE_USER:$HTTPD_SOURCE_GROUP $HTTPD_PREFIX
    logger info "change $HTTPD_BINARY_USER:$HTTPD_BINARY_GROUP to own httpd's binary"
    chown $HTTPD_BINARY_USER:$HTTPD_BINARY_GROUP $HTTPD_PREFIX/bin/httpd
    chmod $HTTPD_BINARY_PERMISSION $HTTPD_PREFIX/bin/httpd
  fi
}

main
