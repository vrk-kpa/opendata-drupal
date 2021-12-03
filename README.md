# opendata-drupal
[![Build](https://github.com/vrk-kpa/opendata-drupal/actions/workflows/main.yml/badge.svg)](https://github.com/vrk-kpa/opendata-drupal/actions/workflows/main.yml)

Drupal docker image for open data portal (avoindata.fi). 

### Local development

Local development environment is built using docker-compose. The files are in the ´local´ folder and the compose file is setup so that only `drupal` image is built, other images are pulled with `latest` tags.

#### Build & run

```bash
# build frontend (in modules/ytp-assets-common/)
npm install && gulp
# bring docker services up (in local/)
docker-compose -p opendata-drupal up --build -d
```

#### Live editing

The following folders can be edited live, they are mounted directly from host.

* modules/avoindata-*
* modules/ytp-assets-common/resources
