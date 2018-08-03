FROM ubuntu:18.10

#
# Update System
#
RUN apt-get update -y; \
    apt-get install apache2 -y;

#RUN apt-get install software-properties-common -y;
#
#RUN add-apt-repository ppa:ondrej/php -y; exit 0;
#RUN apt-get update;

#RUN apt-get install php5.6;