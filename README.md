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

### Copy WP Dir

``` shell
# 非部署机器
sftp username@host

cd ~/workdir/build-wp-nginx

put /path/to/blog.tar.gz .
```

### Build Image
```shell
# 部署机器
cd ~/workdir/build-wp-nginx
docker build -t wp-nginx .
```

### Start Container
```shell
# 部署机器
docker run -dp 80:80 --name wp-nginx wp-nginx:latest
```




