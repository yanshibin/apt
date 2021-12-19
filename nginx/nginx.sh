#!/bin/bash
# static nginx test with debian 11

SRC="https://raw.githubusercontent.com/MoeClub/apt/master"

apt install -y wget make gcc build-essential xz-utils
[ $? -eq 0 ] || exit 1


cd /tmp
# luajit
rm -rf ./luajit; mkdir -p ./luajit; rm -rf /usr/local/LuaJIT
wget -qO- "${SRC}/nginx/src/luajit/luajit_2.0.4.tar.gz" |tar -zxv --strip-components 1 -C ./luajit
cd ./luajit
make install PREFIX=/usr/local/LuaJIT -j $(grep "cpu cores" /proc/cpuinfo | wc -l)
[ $? -eq 0 ] || exit 1

export LUAJIT_LIB=/usr/local/LuaJIT/lib
export LUAJIT_INC=/usr/local/LuaJIT/include/luajit-2.0


cd /tmp
# nginx
rm -rf ./nginx; mkdir -p ./nginx
wget -qO- "${SRC}/nginx/src/nginx/nginx_1.18.0.tar.gz" |tar -zxv --strip-components 1 -C ./nginx

cd ./nginx
rm -rf ./nginx/modules; mkdir -p ./nginx/modules

mkdir -p ./nginx/modules/http-subs-filter && wget -qO- "${SRC}/nginx/src/nginxModule/http-subs-filter_v0.6.4.tar.gz" |tar -zxv --strip-components 1 -C ./nginx/modules/http-subs-filter
mkdir -p ./nginx/modules/http-echo && wget -qO- "${SRC}/nginx/src/nginxModule/http-echo_v0.62.tar.gz" |tar -zxv --strip-components 1 -C ./nginx/modules/http-echo
mkdir -p ./nginx/modules/http-ndk && wget -qO- "${SRC}/nginx/src/nginxModule/http-ndk_v0.3.1.tar.gz" |tar -zxv --strip-components 1 -C ./nginx/modules/http-ndk
mkdir -p ./nginx/modules/http-lua && wget -qO- "${SRC}/nginx/src/nginxModule/http-lua_v0.10.20.tar.gz" |tar -zxv --strip-components 1 -C ./nginx/modules/http-lua

ExtModule=""; for item in `find ./modules/ -maxdepth 1 -type d`; do echo "$item" |grep -q '/$' || ExtModule="${ExtModule}--add-module=${item} "; done

# openssl
rm -rf ../openssl; mkdir -p ../openssl
wget -qO- "${SRC}/nginx/src/openssl/openssl-1.1.1k.tar.gz" |tar -zxv --strip-components 1 -C ../openssl

# pcre
rm -rf ../pcre; mkdir -p ../pcre
wget -qO- "${SRC}/nginx/src/pcre/pcre-8.45.tar.gz" | tar -zxv --strip-components 1 -C ../pcre

# zlib
rm -rf ../zlib; mkdir -p ../zlib
wget -qO- "${SRC}/nginx/src/zlib/zlib-1.2.11.tar.gz" | tar -zxv --strip-components 1 -C ../zlib


# build nginx
./configure \
--with-cc-opt="-static -static-libgcc" \
--with-ld-opt="-static" \
--with-cpu-opt=generic \
--prefix=/usr/share/nginx \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/dev/null \
--http-log-path=/dev/null \
--lock-path=/var/lock/nginx.lock \
--pid-path=/run/nginx.pid \
--modules-path=/usr/lib/nginx/modules \
--http-client-body-temp-path=/var/lib/nginx/body \
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
--http-proxy-temp-path=/var/lib/nginx/proxy \
--http-scgi-temp-path=/var/lib/nginx/scgi \
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
--with-threads \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_flv_module \
--with-http_gzip_static_module \
--with-http_gunzip_module \
--with-http_mp4_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_v2_module \
--without-http_geo_module \
--without-http_userid_module \
--without-http_memcached_module \
--without-http_split_clients_module \
--with-pcre=../pcre \
--with-zlib=../zlib \
--with-openssl=../openssl \
${ExtModule}
[ $? -eq 0 ] || exit 1

make -j $(grep "cpu cores" /proc/cpuinfo | wc -l)
[ $? -eq 0 ] && echo "$(pwd)/objs/nginx" || exit 1