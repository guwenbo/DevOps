# Introduction

The `main.sh` will download tomcat-8.5.29 (default) and uncompress to /usr/local/tomcat (default), it will also configure tomcat automatically, such as:

* use user named tomcat and group named devops to own source dir
* create tomcat's super user
* modify max jar size for tomcat to 100MB
* create tomcat.service to autostart

## How to use ?
```
$ sudo ./main.sh
```
