#For CentOS 7
#FROM centos:7.4.1708
FROM centos:centos7

LABEL maintainer="romain@f5.com"
# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
COPY etc/ssl/nginx/nginx-repo.crt /etc/ssl/nginx/nginx-repo.crt
COPY etc/ssl/nginx/nginx-repo.key /etc/ssl/nginx/nginx-repo.key
# Install prerequisite packages
RUN yum -y install wget ca-certificates epel-release vim-minimal bind-utils

# Add NGINX Plus repo to yum
RUN wget -P /etc/yum.repos.d https://cs.nginx.com/static/files/nginx-plus-7.repo

# Install NGINX App Protect
RUN yum -y install app-protect \
   && yum clean all \
   && rm -rf /var/cache/yum \
   && rm -rf /etc/ssl/nginx

# Forward request logs to Docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#    && ln -sf /dev/stderr /var/log/nginx/error.log

# Copy configuration files
COPY etc/nginx/nginx.conf etc/nginx/log-default.json /etc/nginx/
COPY etc/nginx/conf.d /etc/nginx/conf.d
COPY etc/ssl /etc/ssl
COPY entrypoint.sh  ./
COPY etc/ssl /etc/ssl

CMD ["sh", "/entrypoint.sh"]
EXPOSE 80 443 8080