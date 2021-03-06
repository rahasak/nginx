FROM ubuntu:14.04

MAINTAINER Eranga Bandara (erangaeb@gmail.com)

# install nginx
RUN apt-get update -y
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y
RUN apt-get install -y nginx

# deamon mode off
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# volume
#VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/var/log/nginx"]

# expose ports
EXPOSE 80 443

# add nginx conf
ADD config/portal.com /etc/nginx/sites-available/portal.com
ADD config/rahasak.com /etc/nginx/sites-available/rahasak.com
ADD config/pay.com /etc/nginx/sites-available/pay.com

RUN ln -s /etc/nginx/sites-available/portal.com /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/rahasak.com /etc/nginx/sites-enabled/
RUN ln -s /etc/nginx/sites-available/pay.com /etc/nginx/sites-enabled/

WORKDIR /etc/nginx

CMD ["nginx"]
