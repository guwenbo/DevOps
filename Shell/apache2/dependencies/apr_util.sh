#!/bin/bash
#
# ********************************************************************************************
# *                       What does this script do?
# *
# * (1). Download apr-util (Apache Portable Runtime Utility, default: 1.6.1)
# * (2). Uncompress it to /usr/local/src/httpd_source_tree_root/srclib without version numbers
# *
# *
# * INFO:
# *
# *    Author:      gin
# *    Mail:        bobo1314love@vip.qq.com
# *    Create on:   2018/03/29 17:30
# *    Update on:
# *
# ********************************************************************************************


set -e

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin


if [[ -z $APR_UTIL_RELEASE_VERSION ]]; then
  # import configuration
  source ../settings/httpd.conf
  source ../settings/apr_util.conf
  # import log utils
  source ../../utils/log/log.sh
fi


download_and_uncompress() {
  logger info "Start to download ${APR_UTIL_TAR_NAME} and uncompress"
  curl ${APR_UTIL_RESOURCE} | tar -xz -f - -C ${HTTPD_LIB_PATH}
  # rename apr-util without version number
  mv ${HTTPD_LIB_PATH}/${APR_UTIL_TAR_NAME} ${HTTPD_LIB_PATH}/apr-util
  logger info "Download and uncompress completely"
}


prompt() {
    logger success "Congratulations! You've just download and uncompress ${APR_UTIL_TAR_NAME}"
}


main() {
  download_and_uncompress
  prompt
}

main
