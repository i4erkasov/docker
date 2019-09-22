FROM nginx
MAINTAINER Ivan Cherkasov <i.4erkasov@gmail.com>

ENV APP_ENTRYPOINT /var/www/index.php
ENV FPM_UPSTREAM 127.0.0.1:9000

COPY docker-entrypoint.sh /
COPY default.template /etc/nginx/default.template

RUN chmod 755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]