
FROM serasoft/alpine:3.14

RUN apk update \
  && apk add --no-cache bash curl git apache2 apache2-ssl apache2-utils php7 \
    php7-common php7-curl php7-simplexml php7-xmlwriter php7-json php7-mysqli php7-intl php7-dom \
    php7-fileinfo php7-ctype php7-tokenizer php-xml \
    php7-mbstring php7-zip php7-imap php7-gd php7-phar zlib zlib-dev sed curl \
    ca-certificates \ 
  && rm -rf /var/cache/apk/*  \
  && adduser -D -s /bin/bash -h /var/www/localhost/htdocs suitecrm 

RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
 && php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('/tmp/composer-setup.php'); } echo PHP_EOL;" \
 && php /tmp/composer-setup.php --install-dir=/usr/bin --filename=composer 

RUN php -r "unlink('/tmp/composer-setup.php');" \
    sed -i -e "s/output_buffering\s*=\s*4096/output_buffering = Off/g" \
           -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" \
           -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1G/g" \
           -e "s/post_max_size\s*=\s*8M/post_max_size = 1G/g" \
           -e "s:;\s*session.save_path\s*=\s*\"N;/path\":session.save_path = /tmp:g" \
        /etc/php7/php.ini

USER suitecrm

RUN git clone https://github.com/salesagility/SuiteCRM.git /var/www/localhost/htdocs/suitecrm \
  && cd /var/www/localhost/htdocs/suitecrm \
  && git checkout tags/v7.12.1 -b v7.12.1-R 

RUN cd /var/www/localhost/htdocs/suitecrm \
  && composer install \
  && mkdir -p cache/{images,layout,pdf,xml,include/javascript} \
  && chmod -R 755 . \
  && chmod -R 775 cache custom modules themes data upload \
  && rm /var/www/localhost/htdocs/index.html

EXPOSE 80
