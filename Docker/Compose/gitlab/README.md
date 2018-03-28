# GitLab docker compose

## Overview

The gitlab docker compose use:

* gitlab/gitlab-ce:rc
* postgres:9.6
* redis:3.2.11


## how to use ?

ensure you have installed `docker` and `docker-compose` currently, then:

```
$ docker-compose up -d
```

If you want to see logs, please:

```
$ docker-compose logs -f gitlab
```


## Ref
https://docs.gitlab.com/omnibus/docker/README.html
