# Build Nginx Docker Images for WP

此项目的目的是简化wordpress的部署流程，达到一键部署的目的。

注意，本项目不包含数据库的部署。

## build step 

* 部署机上clone本项目
* 复制wordpress目录（改名为blog）的tar.gz到本项目目录下
* 使用docker build构件镜像
* 启动容器

**假设部署机器上的工作目录是 ~/workdir**


### Clone This Project

``` shell
# 部署机器
mkdir ~/workdir

cd ~/workdir

git clone git@github.com:Aaron-srider/build-docker-image-for-wp.git
```

### Archive Your Wp

此步将你的WP目录打成tar.gz

如果以前没部署过自己的WP网站，可以去官网下载最新的:https://wordpress.org/download/

下下来后是zip，请自行解压，然后改名文件夹（wordpress->blog），打成blog.tar.gz

如果已经有WP网站了，可以参考以下步骤进行打包

``` shell
# 假设你的wp网址的根目录是 /var/www/html

cd /var/www/html

cp your-wp-dir blog -r

tar -cf blog.tar.gz blog

rm -rf blog
```

### Copy WP Archive

``` shell

# 此步适用于blog.tar.gz 不在部署机上的情况，如果blog.tar.gz 已经在部署机器上，可以直接复制到项目目录下
# 非部署机器
sftp username@host

cd ~/workdir/build-docker-image-for-wp

put /var/www/html/blog.tar.gz .
```

### Build Image
```shell
# 部署机器
cd ~/workdir/build-docker-image-for-wp
docker build -t wp-nginx .
```

### Start Container
```shell
# 部署机器
docker run -dp 80:80 --name wp-nginx wp-nginx:latest
```

### Finish

到这里部署就完成了，为了与数据库对接，请自行到容器中编辑wp-config.php文件，确保数据库的连接信息与你的数据库匹配




