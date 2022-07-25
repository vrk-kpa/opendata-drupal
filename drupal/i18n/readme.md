# How to export source translations #

In drupal container
`docker exec -it opendata_drupal_1 /bin/bash`

Run following to export source translations in english:
`drush locale:export --template > drupal.pot`

Then on host override the old source file by running the following in opendata-drupal root folder
`docker cp opendata_drupal_1:/opt/drupal/drupal.pot ./drupal/i18n`