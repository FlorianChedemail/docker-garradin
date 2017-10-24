FROM php:5.6-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/www

RUN docker-php-ext-install pdo mysql
RUN docker-php-ext-install pdo mysqli

COPY src/ /var/www/html/
COPY config.local.php /var/www/html/config.local.php

RUN chown -R www-data:www-data /var/www/html/

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# hacky way to go around garradin relying on $_SERVER['HTTPS']
# to serve url, resulting in wrong url when using a reverse proxy
RUN echo 'PassEnv HTTPS' > /etc/apache2/conf-enabled/expose-env.conf 
