# debian-based container for wordpress
# VERSION               0.1
FROM debian
MAINTAINER Davide Lucchesi  "davide@lucchesi.nl"

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y -q apache2 wordpress
RUN apt-get clean

RUN a2enmod rewrite vhost_alias
RUN mkdir -p /srv/www
RUN (cp /usr/share/doc/wordpress/examples/setup-mysql.gz /srv/www/ && gunzip /srv/www/setup-mysql.gz && chmod ugo+rx /srv/www/setup-mysql)
RUN chown www-data /etc/wordpress/htaccess

ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

ADD apache.conf /etc/apache2/sites-available/default

VOLUME /etc/wordpress
VOLUME /srv/www
VOLUME /var/log/apache2

EXPOSE 80

CMD ["apache2", "-DFOREGROUND"]

