# Introduction

The `main.sh` will download httpd-2.4.29 (default) and uncompress to /usr/local/src (default) , then it will be maked and installed into /usr/local/apache2 (default), it will also configure httpd automatically, such as:

* use user named apache and group named devops to own source dir
* create dir at $HTTPD_Source/conf/vhost to handle virtual host
* modify listen port to 22000 (default)
* create httpd.service to autostart


## How to use ?
```
$ sudo ./main.sh
```
