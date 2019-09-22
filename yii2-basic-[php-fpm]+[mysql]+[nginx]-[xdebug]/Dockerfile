FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt mbstring mysqli pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

COPY docker/docker-entrypoint.sh /
RUN chown www-data:www-data /var/www \
    && chmod +x /docker-entrypoint.sh

COPY --chown=www-data:www-data . /var/www/

WORKDIR /var/www

ARG XDEBUG
RUN if [ "x$XDEBUG" = "xtrue" ] ; then pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.remote_port=9009' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.idekey="PHPSTORMSITE"' >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'xdebug.remote_connect_back=1' >> /usr/local/etc/php/conf.d/xdebug.ini; \
    fi;

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["php-fpm"]