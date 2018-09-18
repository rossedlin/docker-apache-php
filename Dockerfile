FROM ubuntu:18.10

#
# Install Apache2
#
RUN apt-get update -y; \
    apt-get install apache2 -y; \
    rm -rf /var/lib/apt/lists/*;

#
# Install PHP
#
COPY composer-setup.php composer-setup.php
RUN apt-get update -y; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get install -y tzdata; \
    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
    apt-get install -y curl openssl git unzip; \
    apt-get install -y php php-cli php-curl php-mysql php-common php-mbstring php-xml php-zip; \
    a2enmod rewrite; \
    a2enmod ssl; \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer; \
    rm -rf /var/lib/apt/lists/*;

#
# Configure
#
COPY public /var/www/logs
COPY public /var/www/public
COPY apache2/default.conf /etc/apache2/sites-enabled/000-default.conf

#
# Cleanup
#
RUN rm -R /var/www/html;

#
# Run Apache2
#
WORKDIR /var/www
EXPOSE 80
CMD apachectl -D FOREGROUND