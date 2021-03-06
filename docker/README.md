* 如何安装docker?
  * Ubuntu
    * https://www.myfreax.com/how-to-install-and-use-docker-on-ubuntu-18-04/
    * 整个安装过程步骤较多，参考上面的连接是有效的
    * sudo apt install docker-ce=18.06.1~ce~3-0~ubuntu
   * Debian
    * https://www.myfreax.com/how-to-install-and-use-docker-on-debian-9/
    * 具体做的时候，需要参考ubuntu的步骤，手动指定版本
  * Centos - centos7.9 + docker 18.06.1
    * yum -y update
    * yum remove docker docker-common docker-selinux docker-engine --如果之前安装过
    * yum install -y yum-utils device-mapper-persistent-data lvm2
    * 添加阿里镜像
      * yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    * 查看可用版本
      * yum list docker-ce --showduplicates | sort -r
    * 选择一个版本安装
      * yum -y install docker-ce-18.06.1.ce
    * 启动
      * systemctl start docker
    * 设置开机启动
      * systemctl enable docker
    * 参考资源
      * https://cloud.tencent.com/developer/article/1701451
    * 感想
      * 安装方式比Ubuntu简单
* 查看docker版本
  * docker version
* 如何构建一个image?
  * docker build -t ricky:0.0.1 .
  * docker tag ricky:0.0.1 101.132.172.54:5000/ricky:0.0.1
* 如何搭建docker仓库？
  * sudo docker pull registry:latest
  * sudo docker run -d -p 5000:5000 --name dev -v /tmp/registry:/tmp/registry registry:latest
    * 这个会在后台运行
* 删除所有container
  * docker rm $(docker ps -a -q)
* 如何删除镜像？
  * 先删除容器 docker rm
  * 再删除镜像 docker rmi
* 删除所有不再运行的container?
  * sudo docker rm $(sudo docker ps -a -q)
* 如何以命令行的方式进入/bin/bash内部？
  * docker run -it -p 5631:80 mac:latest /bin/bash
    * 注意这里的80是容器内部的端口,这里的5631是运行这个命令的宿主机端口，这样可以做到命令的map
    * 启示能否做到一个环境一个Docker?
  * docker exec -it 342ceeb517f4 bash
* 如何推送一个image到仓库？
  * 修改配置让推送端可以不基于https
    * vim /etc/docker/daemon.json 
    * {"insecure-registries":["101.132.172.54:5000"]}
      * 需要重启docker: systemctl restart docker
    * mac的具体配置可参考mac-push.png
  * sudo docker tag ricky:0.0.1 localhost:5000/ricky:0.0.1
  * sudo docker push localhost:5000/ricky:0.0.1 或者 sudo docker push 101.132.172.54:5000/ricky:0.0.1
* 如何创建swarm集群？
  * 选择一台机器作为Manager，执行docker swarm init --advertise-addr 8.141.54.77，会看到worker如何加入集群的命令
  * 选择其余的节点作为Worker, 例如 docker swarm join --token SWMTKN-1-5a6f125lfvwz7zd72q0ouqufvbfzb8ijf80krdy3dsf8ad3j9l-e7dr31srgg9odbbz6yh4f7s12 8.141.54.77:2377
  * 安装可视化管理Portainer
    * mkdir -p /data/portainer/
    * chmod -R 777 /data/portainer/
    * docker stack deploy -c docker-stack-manager.yml manager --resolve-image=never
    * 用docker service ls查看service是不是准备好了 - 可能需要等待一段时间，因为下载image需要时间.
  * 大体上的操作按照这个网址来https://my.oschina.net/qbj/blog/3079124
    * Endpoint操作也是按照这个网址来
  * 在master节点上查看集群信息, docker node ls
* 踩坑记
  * 有时候发现无法下载或者上传Image，试试重新运行 sudo docker run -d -p 5000:5000 --name dev -v /tmp/registry:/tmp/registry registry:latest
  * 各种被墙的镜像如何下载？
    * https://www.cnblogs.com/hongdada/p/11395200.html
    * 下载defaultbackend镜像
    docker pull lanny/gcr.io_google_containers_defaultbackend_1.4:v1.4 
    docker tag lanny/gcr.io_google_containers_defaultbackend_1.4:v1.4  gcr.io/google_containers/defaultbackend:1.4
    * docker pull googlecontainer/defaultbackend-amd64:1.5 -> docker pull mirrorgooglecontainers/defaultbackend-amd64:1.5
