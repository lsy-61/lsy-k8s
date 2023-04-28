FROM centos:7

#nginx install

RUN yum install -y wget tar gcc gcc-c++ make pcre pcre-devel zlib zlib-devel bind-utils which cronie crontabs \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

WORKDIR /usr/local/src

RUN wget 'http://nginx.org/download/nginx-1.14.2.tar.gz' \
  && tar -xf nginx-1.14.2.tar.gz

WORKDIR nginx-1.14.2 

RUN ./configure --prefix=/usr/local/nginx \
  && make \
  && make install 

RUN rm -rf /usr/local/src/* \
  && rm -f /usr/local/nginx/conf/nginx.conf \
  && echo "*/1 * * * * /usr/bin/curl -I http://localhost:80" > /var/spool/cron/root
  
WORKDIR /root/

#copy file

COPY start.sh /root/
COPY nginx.conf /usr/local/nginx/conf/

#crond and nginx service start


ENTRYPOINT ["sh","/root/start.sh"]
