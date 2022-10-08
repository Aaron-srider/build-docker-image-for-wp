# FROM my_ubuntu_163_source_nginx:18.04

# WORKDIR /var/www/html

# COPY ./totp-admin-frontend.tar.gz .

# CMD ["sh", "-c", "rm /var/www/html/index*; tar -xf /var/www/html/totp-admin-frontend.tar.gz; mv /var/www/html/dist/* /var/www/html/; service nginx start; while true; do sleep 1; done;"]

FROM ubuntu:18.04

# 换源
COPY sources.list /etc/apt/sources.list

COPY start.sh /start.sh

# 更新
# RUN apt update && apt install -y nginx && apt install -y php7.2-cli php7.2-cgi php7.2-fpm php7.2-mbstring php7.2-mysql curl php7.2-curl

RUN apt update
RUN apt install -y vim

# install php7.2
COPY ./install-php7.2.sh .
RUN ./install-php7.2.sh


# install nginx
RUN apt install -y nginx
# 传入nginx配置文件
COPY default /etc/nginx/sites-available
WORKDIR /var/www/html

RUN echo "fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;" >> /etc/nginx/fastcgi_params
RUN echo "fastcgi_param  PATH_INFO          $fastcgi_script_name;" >> /etc/nginx/fastcgi_params

RUN service php7.2-fpm start
RUN service nginx start
# # 将前端解压到网站根目录
# COPY ./totp-admin-frontend.tar.gz .
# RUN rm /var/www/html/index*
# RUN tar -xf /var/www/html/totp-admin-frontend.tar.gz
# RUN mv /var/www/html/dist/* /var/www/html/

# # 将前端解压到网站根目录
COPY ./blog.tar.gz .
RUN rm /var/www/html/index*
RUN tar -xf /var/www/html/blog.tar.gz

EXPOSE 80



# 启动命令
CMD ["sh", "-c", "/start.sh"]
