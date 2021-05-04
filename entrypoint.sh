#!/bin/sh
JSON_STRING='window.configs = { \
  "CATALOG_URL":"'"${CATALOG_URL}"'", \
  "TMF622_URL":"'"${TMF622_URL}"'" \
}'
sed -i "s@// CONFIGURATIONS_PLACEHOLDER@${JSON_STRING}@" /usr/share/nginx/html/index.html
exec "$@"