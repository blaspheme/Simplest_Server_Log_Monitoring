FROM docker:dind

ARG DEBIAN_FRONTEND=noninteractive

# http://openresty.org/cn/linux-packages.html#alpine
RUN wget 'http://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub' \
    && mv 'admin@openresty.com-5ea678a6.rsa.pub' /etc/apk/keys/ \
    && . /etc/os-release \
    && MAJOR_VER=`echo $VERSION_ID | sed 's/\.[0-9]\+$//'` \
    && echo "http://openresty.org/package/alpine/v$MAJOR_VER/main" | tee -a /etc/apk/repositories \
    && apk update \
    && apk add openresty \
    && mkdir /server /server/logs

# 增加环境变量
ENV PATH="/usr/local/openresty/nginx/sbin:${PATH}"

COPY ./conf /server/conf
COPY ./lua /server/lua

CMD nginx -p /server/ -c conf/nginx.conf -g 'daemon off;'
# CMD ["openresty", "-g", "daemon off;"]
EXPOSE 8000