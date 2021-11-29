#!/bin/bash
set -e

echo "reinit_drupal() ..."

# apply jinja2 templates
jinja2 /opt/templates/settings.php.j2 -o ${SITE_DIR}/default/settings.php
jinja2 /opt/templates/services.yml.j2 -o ${SITE_DIR}/default/services.yml

# rebuild cache
drush cache:rebuild

# apply jinja2 templates
jinja2 --format=yaml /opt/templates/site_config/disqus.settings.yml.j2    -o /opt/drupal/site_config/disqus.settings.yml
jinja2 --format=yaml /opt/templates/site_config/matomo.settings.yml.j2    -o /opt/drupal/site_config/matomo.settings.yml
jinja2 --format=yaml /opt/templates/site_config/recaptcha.settings.yml.j2 -o /opt/drupal/site_config/recaptcha.settings.yml
jinja2 --format=yaml /opt/templates/site_config/smtp.settings.yml.j2      -o /opt/drupal/site_config/smtp.settings.yml
jinja2 --format=yaml /opt/templates/site_config/update.settings.yml.j2    -o /opt/drupal/site_config/update.settings.yml

# disable captcha conditionally
if [ "${CAPTCHA_ENABLED}" != "true" ]; then
  rm -f /opt/drupal/site_config/captcha.settings.yml
  rm -f /opt/drupal/site_config/captcha.captcha_point.user_register_form.yml
  rm -f /opt/drupal/site_config/captcha.captcha_point.contact_message_event_form.yml
  rm -f /opt/drupal/site_config/captcha.captcha_point.contact_message_feedback_form.yml
fi

# import settings
drush config:import -y --partial --source /opt/drupal/site_config

# rebuild cache
drush cache:rebuild
