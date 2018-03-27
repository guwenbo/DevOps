# Introduction

The `main.sh` will download jenkins-2.107.1 (default) to /usr/local/jenkins/src (default), it will also configure jenkins automatically, such as:

* use user named jenkins and group named devops to own source dir
* create directory for saving jenkins' logs
* copy the execution to /usr/local/jenkins/bin
* create jenkins.service to autostart


## How to use ?
```
$ sudo ./main.sh
```
