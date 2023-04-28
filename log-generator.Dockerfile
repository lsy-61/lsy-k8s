FROM centos:7

#nginx install

yum install -y wget tar gcc gcc-c++ make pcre pcre-devel zlib zlib-devel
cd /usr/local/src
wget 'http://nginx.org/download/nginx-1.14.2.tar.gz'
tar -zxf nginx-1.14.2.tar.gz
cd nginx-1.14.2
./configure --prefix=/usr/local/nginx && make && make install
rm -rf /usr/local/src/*

#nginx start

ENTRYPOINT ["/usr/local/nginx/sbin/nginx"]

CMD ["-g","daemon off;"]
