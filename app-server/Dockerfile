# nginxを動作させるalpineのカスタムイメージを作成
FROM alpine:3.12

# composerインストール準備
# マルチステージビルドを利用してcomposerファイルのみ別イメージから抽出
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

ADD ./wake.sh /wake.sh

RUN mkdir -p /etc/apk &&\
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
# Install openrc
    apk update &&\
    apk add openrc vim wget curl nginx php php-fpm composer &&\
# laravelインストールに伴う追加インストール
    apk add  php-xml php-tokenizer php-dom php-fileinfo php-xmlwriter php7-session &&\
# 初期設定
    sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf &&\
    echo 'rc_provide="loopback net"' >> /etc/rc.conf &&\
    sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf &&\
    sed -i '/tty/d' /etc/inittab &&\
    sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname &&\
    sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh &&\
    sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh &&\
    mkdir /run/openrc &&\
    touch /run/openrc/softlevel &&\
    # nginxの設定ファイルを編集
    # ルートアクセス時にindex.htmlを表示するように変更
    sed -i'.bak' 's/return 404;/root html;\n\t\tindex index.html;/' /etc/nginx/conf.d/default.conf &&\
    sed -i '1s/^/pid \/var\/run\/nginx.pid;\n/' /etc/nginx/nginx.conf && nginx &&\
    mkdir /www &&\
    # cd www && composer create-project laravel/laravel=5.5 laravelProject &&\
    mkdir /var/log/nginx/laravelProject/ &&\
    touch /var/log/nginx/laravelProject/access.log &&\
    touch /var/log/nginx/laravelProject/error.log &&\
    # php-fpmの設定
    # cd /usr/bin && ln -s /usr/bin/php-fpm7 php-fpm &&\
    mkdir /var/run/php-fpm && touch /var/run/php-fpm/php-fpm.sock &&\
    chmod -R 744 /wake.sh

# nginxの設定ファイルを反映
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# php-fpmの設定ファイルを反映
COPY ./php-fpm/www.conf  /etc/php7/php-fpm.d/www.conf

WORKDIR /www

# nginxを起動
# CMD ["nginx", "-g", "daemon off;" , "php-fpm7;"]

