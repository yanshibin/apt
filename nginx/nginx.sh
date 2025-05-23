#!/bin/bash
# static nginx test with debian 11

SRC="https://raw.githubusercontent.com/MoeClub/apt/master"

apt install -y wget make gcc build-essential xz-utils
[ $? -eq 0 ] || exit 1

cores=`grep "^processor" /proc/cpuinfo |wc -l`
[ -n "$cores" ] || cores=1

cd /tmp
# glibc
glibcPath="/tmp/glibc"
wget --no-check-certificate -4 -qO glibc.tar.gz https://ftp.gnu.org/pub/gnu/glibc/glibc-2.28.tar.gz
rm -rf ./glibcBuild; rm -rf "$glibcPath"; mkdir -p "$glibcPath"
mkdir -p ./glibcBuild; tar -xz -f glibc.tar.gz -C ./glibcBuild --strip-components=1;
mkdir -p glibcBuild/build; cd glibcBuild/build
CFLAGS="-ffloat-store -O2 --static" \
LDFLAGS="-static -static-libgcc -static-libstdc++ -s -pthread -lpthread" \
../configure \
  --prefix=$glibcPath \
  --enable-static --enable-static-nss \
  --disable-nscd --disable-sanity-checks
[ $? -eq 0 ] || exit 1 
make install -j$cores
find "$glibcPath/lib" ! -type d ! -name "*.a" -delete


cd /tmp
# luajit
LuaJIT="/tmp/LuaJIT"
rm -rf ./luajitBuild; mkdir -p ./luajitBuild; rm -rf "$LuaJIT"; mkdir -p "$LuaJIT"
wget -qO- "${SRC}/nginx/src/luajit/luajit_v2.1-20190221.tar.gz" |tar -zxv --strip-components 1 -C ./luajitBuild
cd ./luajitBuild

make install PREFIX="$LuaJIT" -j $cores
[ $? -eq 0 ] || exit 1

find "${LuaJIT}/lib" -maxdepth 1 -name '*.so*' -delete

export LUAJIT_LIB="${LuaJIT}/lib"
export LUAJIT_INC=`find "${LuaJIT}/include" -maxdepth 1 -type d -name "luajit-*" |sort -n |head -n1`


cd /tmp
# nginx
rm -rf ./nginx; mkdir -p ./nginx
# wget -qO- "${SRC}/nginx/src/nginx/nginx_1.18.0.tar.gz" |tar -zxv --strip-components 1 -C ./nginx
wget -qO- "${SRC}/nginx/src/nginx/nginx-1.22.1.tar.gz" |tar -zxv --strip-components 1 -C ./nginx

cd ./nginx
rm -rf ./modules; mkdir -p ./modules

mkdir -p ./modules/http-subs-filter && wget -qO- "${SRC}/nginx/src/nginxModule/http-subs-filter_v0.6.4.tar.gz" |tar -zxv --strip-components 1 -C ./modules/http-subs-filter
mkdir -p ./modules/http-echo && wget -qO- "${SRC}/nginx/src/nginxModule/http-echo_v0.62.tar.gz" |tar -zxv --strip-components 1 -C ./modules/http-echo
mkdir -p ./modules/http-ndk && wget -qO- "${SRC}/nginx/src/nginxModule/http-ndk_v0.3.1.tar.gz" |tar -zxv --strip-components 1 -C ./modules/http-ndk
mkdir -p ./modules/http-lua && wget -qO- "${SRC}/nginx/src/nginxModule/http-lua_v0.10.14.tar.gz" |tar -zxv --strip-components 1 -C ./modules/http-lua
#[ -f ./modules/http-lua/src/ngx_http_lua_module.c ] && sed -i 's/#ifndef OPENRESTY_LUAJIT/#ifdef OPENRESTY_LUAJIT/' ./modules/http-lua/src/ngx_http_lua_module.c

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
--with-cc-opt="-I../glibc/include -static -static-libgcc" \
--with-ld-opt="-L../glibc/lib -L../glibc/lib64 -static" \
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
--with-http_gzip_static_module \
--with-http_gunzip_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_dav_module \
--with-http_stub_status_module \
--with-stream \
--with-stream_ssl_module \
--with-stream_ssl_preread_module \
--with-file-aio \
--without-http_geo_module \
--without-http_userid_module \
--without-http_memcached_module \
--with-pcre=../pcre \
--with-zlib=../zlib \
--with-openssl=../openssl \
$(echo "$ExtModule")
[ $? -eq 0 ] || exit 1

make -j $cores
[ $? -eq 0 ] && echo "$(pwd)/objs/nginx" || exit 1
