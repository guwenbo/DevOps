# Introduction

The `main.sh` will download nginx-1.10.1 (default) and uncompress to /usr/local/src (default) , then it will be maked and installed into /usr/local/nginx (default), it will also configure nginx automatically, such as:

* use user named nginx and group named devops to own source dir
* create dir at $Nginx_Source/conf/vhost to handle virtual host
* create nginx.service to autostart


## How to use ?
```
$ sudo ./main.sh
```
