#!/bin/bash
#
# ********************************************************************************************
# *                       What does this script do?
# *
# * (1). Download apr (Apache Portable Runtime, default: 1.6.3)
# * (2). Uncompress it to /usr/local/src/httpd_source_tree_root/srclib without version numbers
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/29 17:20
# *    Update on:
# *
# ********************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z $APR_RELEASE_VERSION ]]; then
  # import configuration
  source ../settings/httpd.conf
  source ../settings/apr.conf
  # import log utils
  source ../../utils/log/log.sh
fi


download_and_uncompress() {
  logger info "Start to download ${APR_TAR_NAME} and uncompress"
  curl ${APR_RESOURCE} | tar -xz -f - -C ${HTTPD_LIB_PATH}
  # rename apr without version number
  mv ${HTTPD_LIB_PATH}/${APR_TAR_NAME} ${HTTPD_LIB_PATH}/apr
  logger info "Download and uncompress completely"
}


prompt() {
    logger success "Congratulations! You've just download and uncompress ${APR_TAR_NAME}"
}


main() {
  download_and_uncompress
  prompt
}

main
