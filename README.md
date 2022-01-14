# opendata-drupal
[![Build](https://github.com/vrk-kpa/opendata-drupal/actions/workflows/main.yml/badge.svg)](https://github.com/vrk-kpa/opendata-drupal/actions/workflows/main.yml)

Drupal docker image for open data portal (avoindata.fi). 

## Build arguments

| key | valid values | default value |
| --- | ------------ | ------------- |
| SECRET_NPMRC | any string | - |
| DYNATRACE_ENABLED | 0 or 1 | 0 |

## Environment variables

| key | config affected | variable affected | default value |
| --- | --------------- | ----------------- | ------------- |
| DRUPAL_CONFIG_SYNC_DIRECTORY | settings.php | `config_sync_directory` | - |
| DRUPAL_HASH_SALT | settings.php | `hash_salt` | - |
| DRUPAL_IMAGE_TAG | entrypoint.sh, init_drupal.sh | `.init-done` | - |
| DB_HOST | settings.php | `$databases['default']['default']['host']` | - |
| DB_DRUPAL | settings.php | `$databases['default']['default']['database']` | - |
| DB_DRUPAL_USER | settings.php | `$databases['default']['default']['username']` | - |
| DB_DRUPAL_PASS | settings.php | `$databases['default']['default']['password']` | - |
| DOMAIN_NAME | settings.php | `trusted_host_patterns` | - |
| SECONDARY_DOMAIN_NAME | settings.php | `trusted_host_patterns` | - |
| SITE_NAME | init_drupal.sh | `drush site:install --site-name` | - |
| SYSADMIN_USER | init_drupal.sh | `drush site:install --account-name` | - |
| SYSADMIN_PASS | init_drupal.sh | `drush site:install --account-pass` | - |
| SYSADMIN_EMAIL | init_drupal.sh | `drush site:install --account-mail` | - |
| SYSADMIN_ROLES | init_users.py | `sysadmin_roles` | - |
| NGINX_HOST | settings.php, various modules | `trusted_host_patterns`, `ckan api connection strings` | - |
| SMTP_HOST | smtp.settings.yml | `smtp_host` | - |
| SMTP_USERNAME | smtp.settings.yml | `smtp_username` | - |
| SMTP_PASS | smtp.settings.yml | `smtp_password` | - |
| SMTP_FROM | smtp.settings.yml | `smtp_from` | - |
| SMTP_PROTOCOL | smtp.settings.yml | `smtp_protocol` | - |
| SMTP_PORT | smtp.settings.yml | `smtp_port` | - |
| MATOMO_ENABLED | matomo.settings.yml | `enables or disables matomo` | - |
| MATOMO_SITE_ID | matomo.settings.yml | `site_id` | - |
| MATOMO_DOMAIN | matomo.settings.yml | `url_http`, `url_https` | - |
| CAPTCHA_ENABLED | init_drupal.sh, reinit_drupal.sh | `enables or disables captcha` | - |
| RECAPTCHA_PUBLIC_KEY | recaptcha.settings.yml | `site_key` | - |
| RECAPTCHA_PRIVATE_KEY | recaptcha.settings.yml | `secret_key` | - |
| USERS_N_USER | init_users.py | `username` | - |
| USERS_N_PASS | init_users.py | `password` | - |
| USERS_N_EMAIL | init_users.py | `email` | - |
| USERS_N_ROLES | init_users.py | `roles` | - |

## Copying and License

This material is copyright (c) 2013-2021 Digital and Population Data Services Agency, Finland.

Drupal modules are licensed under the GNU Affero General Public License (AGPL) v3.0
whose full text may be found at: http://www.fsf.org/licensing/licenses/agpl-3.0.html

All other content in this repository is licensed under MIT License unless otherwise specified.
