# 安装
```
curl -fsSL https://get.docker.com | bash -s docker
wget -qO- https://raw.githubusercontent.com/MoeClub/Note/master/docker.sh |bash
```
# 登陆
```
docker login
```
# 获取镜像
```
docker pull vicer/app:debian9
```
# 列出镜像
```
docker images
```
# 移除镜像
```
docker rmi -f <ImageID>
docker images -a -q |xargs docker rmi -f
```
# 将修改过的docker容器提交成镜像
```
docker commit -p <ContainerID> [REPOSITORY[:TAG]]

```
# 打标签
```
docker tag <ImageID> <UserName>/debian9:latest
```
# 上传
```
docker push <UserName>/debian9:latest
```
# 注销登录
```
docker logout
```
# DockerFile
```
docker build -t image:latest ./DockerFile
```
# 测试
```
docker rm -f <DockerName>
docker run --name <DockerName> --env XX=YY --privileged -p 60443:443 -d <ImageID>

docker container list
docker exec -it <ContainerID> /bin/bash

```

# 简易使用 Docker
```
docker pull ubuntu:latest
docker run --rm  -v "$HOME/Downloads:/home/Downloads" --privileged=true --name ubuntu -itd ubuntu:latest

docker ps -a
docker stop ubuntu

docker ps -q -f status=exited -f status=dead |xargs docker rm 

docker exec -it ubuntu /bin/bash


```

