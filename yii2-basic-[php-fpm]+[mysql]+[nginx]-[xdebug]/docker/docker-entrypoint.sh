#!/bin/bash

function init_database() {
    php /var/www/yii migrate --interactive=0
}

if [ -n "$1" ]; then
    if [ "$INIT_ENV" == "true"  ]; then
        init_env $ENV
    fi

    if [ "$INIT_DATABASE" == "true"  ]; then
        while true; do
          php -r "@fsockopen('$DB_HOST', 3306) or exit(1); exit(0);" && break
          echo "wait DB connection...";
          sleep 3
        done

        init_database
    fi

    if [ "$CHMOD" = "true"  ]; then
        chmod 777 -R /var/www/web/assets
        chmod 777 -R /var/www/runtime
    fi

    exec "$@"
fi