## [1.4.1](https://github.com/vrk-kpa/opendata-drupal/compare/v1.4.0...v1.4.1) (2022-01-27)


### Bug Fixes

* update drupal from 9.2.8 to 9.3.3 ([9eeb103](https://github.com/vrk-kpa/opendata-drupal/commit/9eeb10363016ddd351be968c280607e50d24c3dd))

# [1.4.0](https://github.com/vrk-kpa/opendata-drupal/compare/v1.3.5...v1.4.0) (2022-01-25)


### Features

* **AV-1614:** switch php-fpm with apache, simplifies volumes significantly ([53e179f](https://github.com/vrk-kpa/opendata-drupal/commit/53e179ffa6e8ce767887bad2efbe6648c68c865f))

## [1.3.5](https://github.com/vrk-kpa/opendata-drupal/compare/v1.3.4...v1.3.5) (2022-01-25)


### Bug Fixes

* **AV-1612:** remove old avoindata-ckeditor-plugins src files ([353c425](https://github.com/vrk-kpa/opendata-drupal/commit/353c425323ba64ca7c89f8dd90a5a5dbcd35ceb8))
* **AV-1612:** setup drupal modules dir to be a shared volume (docker or EFS) ([6538fef](https://github.com/vrk-kpa/opendata-drupal/commit/6538fef24449a588cf3c88cf5cdb979f7542ed0e))

## [1.3.4](https://github.com/vrk-kpa/opendata-drupal/compare/v1.3.3...v1.3.4) (2022-01-21)


### Bug Fixes

* **AV-1569:** update modules from main repo ([994638f](https://github.com/vrk-kpa/opendata-drupal/commit/994638fcc49c2fb85a805f1cbeb67e5dfc6ce2ae))
* **AV-1569:** update submodules ([00e3358](https://github.com/vrk-kpa/opendata-drupal/commit/00e33580ad1649a179a055a9e7e27c880c9a84b4))

## [1.3.3](https://github.com/vrk-kpa/opendata-drupal/compare/v1.3.2...v1.3.3) (2022-01-20)


### Bug Fixes

* improve init_drupal.sh execution time significantly against already initialized db ([3152e30](https://github.com/vrk-kpa/opendata-drupal/commit/3152e30df638d77eb948f565412d9279af99b8b8))
* remove EFS migration procedure from init_filesystems.sh ([0613b09](https://github.com/vrk-kpa/opendata-drupal/commit/0613b0995409e79365af4d227bfc530f70179ca0))

## [1.3.2](https://github.com/vrk-kpa/opendata-drupal/compare/v1.3.1...v1.3.2) (2022-01-19)


### Bug Fixes

* correct 'reverse_proxy_trusted_headers' value in settings.php ([662848a](https://github.com/vrk-kpa/opendata-drupal/commit/662848a9a6b5495147b064784a860d317e0dac5f))

## [1.3.1](https://github.com/vrk-kpa/opendata-drupal/compare/v1.3.0...v1.3.1) (2022-01-19)


### Bug Fixes

* add configs for local dev mode to improve developer experience ([bc19ea9](https://github.com/vrk-kpa/opendata-drupal/commit/bc19ea9a5cedb3ad215dbc62059a5434724ab1ec))

# [1.3.0](https://github.com/vrk-kpa/opendata-drupal/compare/v1.2.4...v1.3.0) (2022-01-12)


### Features

* add optional integration to dynatrace ([1a2b4ac](https://github.com/vrk-kpa/opendata-drupal/commit/1a2b4ac8e3f038190f0fbed5c763eca5eabd32f2))

## [1.2.4](https://github.com/vrk-kpa/opendata-drupal/compare/v1.2.3...v1.2.4) (2022-01-05)


### Bug Fixes

* correct some module references in frontend gulpfile ([392c7bd](https://github.com/vrk-kpa/opendata-drupal/commit/392c7bd7baed313be1434b94775fcf0792f44ee0))

## [1.2.3](https://github.com/vrk-kpa/opendata-drupal/compare/v1.2.2...v1.2.3) (2022-01-04)


### Bug Fixes

* necessary structural changes for using opendata-frontend as a submodule ([694cee0](https://github.com/vrk-kpa/opendata-drupal/commit/694cee05177fddac483eb783aec4c77a0312e173))

## [1.2.2](https://github.com/vrk-kpa/opendata-drupal/compare/v1.2.1...v1.2.2) (2021-12-31)


### Bug Fixes

* **AV-1569:** improve init_filesystems script ([c5dfc68](https://github.com/vrk-kpa/opendata-drupal/commit/c5dfc688c9a414272182e3bb154bf4c9da998710))
* **ci:** simplify release job to mitigate random AWS OIDC problems ([66f550b](https://github.com/vrk-kpa/opendata-drupal/commit/66f550be5ec9daecadbb3af40efda140ee590304))

## [1.2.1](https://github.com/vrk-kpa/opendata-drupal/compare/v1.2.0...v1.2.1) (2021-12-30)


### Bug Fixes

* **AV-1569:** apply docker/ecs env related changes to updated modules ([717ab5b](https://github.com/vrk-kpa/opendata-drupal/commit/717ab5bd16f27a974c500c4462217bee3f78b134))
* **AV-1569:** correct path issues in frontend project ([816c553](https://github.com/vrk-kpa/opendata-drupal/commit/816c5536b64dcfaef7dc4bfb674e215b14d0e371))
* **AV-1569:** update i18n ([f935bf2](https://github.com/vrk-kpa/opendata-drupal/commit/f935bf2814d51583cf20b86cde4e1d36cd65da97))
* **AV-1569:** update modules from main repo + fix line endings to LF ([76ab35a](https://github.com/vrk-kpa/opendata-drupal/commit/76ab35aa445468cae018540580f430290f356b17))

# [1.2.0](https://github.com/vrk-kpa/opendata-drupal/compare/v1.1.2...v1.2.0) (2021-12-28)


### Bug Fixes

* **AV-1563:** revert ckan-2.9 related changes, keep refactor ([26d3aa8](https://github.com/vrk-kpa/opendata-drupal/commit/26d3aa8b1450bc7516a07ae4bd2c10a442260ba7))


### Features

* **AV-1563:** reflect changes done in ckan 2.8 -> 2.9 migration, refactor ([8cb7902](https://github.com/vrk-kpa/opendata-drupal/commit/8cb7902cbde734581434f0348028da6edd17647a))

## [1.1.2](https://github.com/vrk-kpa/opendata-drupal/compare/v1.1.1...v1.1.2) (2021-12-10)


### Bug Fixes

* **drupal:** set version number to 9.2 for drupal base image ([d67b361](https://github.com/vrk-kpa/opendata-drupal/commit/d67b361fdac4990795702a226a5780a361828f25))

## [1.1.1](https://github.com/vrk-kpa/opendata-drupal/compare/v1.1.0...v1.1.1) (2021-12-09)


### Bug Fixes

* rename DRUPAL_IMAGE_VERSION to DRUPAL_IMAGE_TAG ([e03f889](https://github.com/vrk-kpa/opendata-drupal/commit/e03f889b601485a3c0e0dcca1df87b517c045fdf))

# [1.1.0](https://github.com/vrk-kpa/opendata-drupal/compare/v1.0.0...v1.1.0) (2021-12-03)


### Features

* AV-1487: Local development environment ([#2](https://github.com/vrk-kpa/opendata-drupal/issues/2)) ([71f94bc](https://github.com/vrk-kpa/opendata-drupal/commit/71f94bc68707487891c1872640bb8dc9e06551af))

# 1.0.0 (2021-12-02)


### Bug Fixes

* **ci:** initial workflow setup for test, build, push, release ([10b67e9](https://github.com/vrk-kpa/opendata-drupal/commit/10b67e92c98d6d046587a2f9b3256602cd3ab1dc))
* **ci:** semantic-release based test/build/release workflows ([9e943d0](https://github.com/vrk-kpa/opendata-drupal/commit/9e943d0fcfa30f4b94270e3fb7003a299ec888b1))


### Features

* initial commit ([531916b](https://github.com/vrk-kpa/opendata-drupal/commit/531916b3cd64e44253209bdef0afe73990a20c00))
