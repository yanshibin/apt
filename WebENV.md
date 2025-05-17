# Debian ENV
```
DEBIAN_FRONTEND=noninteractive apt-get install -y openssl wget curl screen nload unzip vnstat gawk dnsutils net-tools p7zip-full python3-pip ipset iftop lsof

DEBIAN_FRONTEND=noninteractive apt-get install -y nginx mariadb-client mariadb-server
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/php.sh') 5.6

```


# Linux BBR
```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/apt/master/bbr/bbr.sh') 0 0

```

# Debian Nginx
```
apt install -y nginx
bash <(wget -qO- https://github.com/MoeClub/apt/raw/master/nginx/conf/nginx.sh)

```

# Linux limits
```
[ -f /etc/security/limits.conf ] && LIMIT='1048576' && sed -i '/^\(\*\|root\)[[:space:]]*\(hard\|soft\)[[:space:]]*\(nofile\|memlock\)/d' /etc/security/limits.conf && echo -ne "*\thard\tmemlock\t${LIMIT}\n*\tsoft\tmemlock\t${LIMIT}\nroot\thard\tmemlock\t${LIMIT}\nroot\tsoft\tmemlock\t${LIMIT}\n*\thard\tnofile\t${LIMIT}\n*\tsoft\tnofile\t${LIMIT}\nroot\thard\tnofile\t${LIMIT}\nroot\tsoft\tnofile\t${LIMIT}\n\n" >>/etc/security/limits.conf
[ -f /etc/systemd/system.conf ] && sed -i 's/#\?DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1048576/' /etc/systemd/system.conf

```

# ReInstall
```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 10 -v 64 -a
```

# ReInstall CN
```
bash <(wget --no-check-certificate -qO- 'https://moeclub.org/attachment/LinuxShell/InstallNET.sh') -d 10 -v 64 -a --mirror http://mirrors.ustc.edu.cn/debian
```

# Linux Init
```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/LinuxInit.sh')

```

# Install Win8.1
```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -dd "https://api.moeclub.org/redirect/win8.1emb_x64.tar.gz"
```

# Timezone
```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" >/etc/timezone
```

# Root
```
#!/bin/bash
echo root:Vicer |sudo chpasswd root
sudo sed -i 's/^#\?Port.*/Port 22/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
sudo rm -rf /etc/ssh/sshd_config.d/*;
sudo systemctl restart sshd
```

# Windows Image
```
# win7emb_x86.tar.gz:
https://api.moeclub.org/GoogleDrive/1srhylymTjYS-Ky8uLw4R6LCWfAo1F3s7 
https://api.moeclub.org/redirect/win7emb_x86.tar.gz

# win8.1emb_x64.tar.gz:
https://api.moeclub.org/GoogleDrive/1cqVl2wSGx92UTdhOxU9pW3wJgmvZMT_J
https://api.moeclub.org/redirect/win8.1emb_x64.tar.gz

# win10ltsc_x64.tar.gz:
https://api.moeclub.org/GoogleDrive/1OVA3t-ZI2arkM4E4gKvofcBN9aoVdneh
https://api.moeclub.org/redirect/win10ltsc_x64.tar.gz
```

# Linux sysctl.conf
```
# This line below add by user.

fs.file-max = 104857600
fs.nr_open = 1048576
vm.overcommit_memory = 1
vm.swappiness = 10
net.core.somaxconn = 65535
net.core.optmem_max = 1048576
net.core.rmem_max = 8388608
net.core.wmem_max = 8388608
net.core.rmem_default = 1048576
net.core.wmem_default = 1048576
net.core.netdev_max_backlog = 65536
net.ipv4.tcp_mem = 2097152 8388608 16777216 
net.ipv4.tcp_rmem = 16384 524288 16777216
net.ipv4.tcp_wmem = 16384 524288 16777216
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_syn_retries = 3
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_max_syn_backlog = 65535
net.ipv4.tcp_fin_timeout = 16
net.ipv4.tcp_keepalive_intvl = 32
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_time = 900
net.ipv4.tcp_retries1 = 3
net.ipv4.tcp_retries2 = 8
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.ip_forward = 1

net.ipv4.icmp_echo_ignore_all = 1
net.ipv6.conf.all.disable_ipv6 = 1

net.ipv4.tcp_fastopen = 0
net.ipv4.tcp_fack = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_dsack = 1
net.ipv4.tcp_ecn = 0
net.ipv4.tcp_ecn_fallback = 1

net.core.default_qdisc = fq_codel
net.ipv4.tcp_congestion_control = bbr


```

# Run with user
```
start-stop-daemon --start --quiet --chuid "<USER>" --name "<ExecName>" --exec "<ExecPath>" -- <ARGVS>

```

# scp
```
scp -P 22 -r <DIR> user@host:<DIR>

```

# rcone
```
./rclone copy --no-check-certificate --progress --checksum --min-size 50M --multi-thread-streams 8 --transfers 8 --drive-shared-with-me

```

# nvm, nodejs, npm
```
## wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

### nvm ls-remote | grep LTS
## nvm install v8.9.0
## npm install --global gulp-cli

rm -rf /usr/local/bin/node /usr/local/include/node /usr/local/lib/node_modules

version="v16.16.0" && arch="arm64"
wget -qO- "https://nodejs.org/dist/v16.16.0/node-${version}-linux-${arch}.tar.xz" |tar -Jxv --strip-components=1 -C /usr/local

```

# nload
```
echo -ne 'DataFormat="Human Readable (Byte)"\nTrafficFormat="Human Readable (Byte)"\n' >/etc/nload.conf

```

# ntpdate
```
ntpdate -4 time.windows.com time.apple.com

```

# fstab
```
fdisk /dev/sdc #[g,n,w]
mkfs -t ext4 /dev/sdc1

mkdir -p /data
uuid=`lsblk -no UUID /dev/sdc1`
if [ -f /etc/fstab ]; then
  sed -i "/${uuid}/d" /etc/fstab
  while [ -z "$(sed -n '$p' /etc/fstab)" ]; do sed -i '$d' /etc/fstab; done
  sed -i "\$aUUID=${uuid}\t/data\text4\tdefaults,nofail,noatime,nodiratime,nobarrier\t0\t2\n\n" /etc/fstab
fi

# /dev/sdc /data ext4 defaults,nofail,noatime,nodiratime,nobarrier 0 2

```

# journalctl
```
# disable
sed -i 's/^#\?Storage=.*/Storage=none/' /etc/systemd/journald.conf

# keep & limit in memory
sed -i 's/^#\?Storage=.*/Storage=volatile/' /etc/systemd/journald.conf
sed -i 's/^#\?SystemMaxUse=.*/SystemMaxUse=8M/' /etc/systemd/journald.conf
sed -i 's/^#\?RuntimeMaxUse=.*/RuntimeMaxUse=8M/' /etc/systemd/journald.conf

# restart service
systemctl restart systemd-journald
systemctl status systemd-journald

# watch 
journalctl -f -u <service.name>

# manual
journalctl --rotate

journalctl --vacuum-size=8M
journalctl --vacuum-files=1
journalctl --vacuum-time=7d
```

# nvidia & cuda
```
echo "deb http://deb.debian.org/debian/ buster main contrib non-free" >>/etc/apt/sources.list
apt update
DEBIAN_FRONTEND=noninteractive apt install -y nvidia-driver nvidia-cuda-toolkit nvidia-kernel-dkms firmware-misc-nonfree

# nvidia-smi
# apt install -y "linux-headers-`uname -r`"
# sudo dkms install -m `ls -1 /usr/src |grep "^nvidia" |sed 's/^nvidia-/nvidia\//'`
```

# ssh config
```
echo -ne "# chmod 600 ~/.ssh/id_rsa\n\nHost *\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n  IdentityFile ~/.ssh/id_rsa\n" > ~/.ssh/config

```

# ssh keygen
```
ssh-keygen -t rsa -P "" -f ./id_rsa

cat id_rsa.pub
cat id_rsa

```

# OneDrive
```
https://[tenancy]-my.sharepoint.com/personal/[user]_[tenancy]_onmicrosoft_com/_layouts/15/download.aspx?share=[FileID]

```

# Login Root
```
PASSWORD='MoeClub.org'; echo $PASSWORD |sudo -S true; echo root:$PASSWORD |sudo chpasswd root; sudo apt update; sudo apt install -y openssh-server; sudo apt install -y sshpass; sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config; sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config; sudo systemctl enable sshd; sudo systemctl restart sshd; sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no root@localhost

```

# MySQL
```
# 数据库
CREATE DATABASE <DatabaseName>;
DROP DATABASE <DatabaseName>;

# 查看用户
SELECT Host,User,Password FROM mysql.user;

# 修改密码
UPDATE mysql.user SET Password=password('P@ssword') WHERE User='root' and Host='localhost'; 

# 创建用户(MoeClub)和密码(MoeClub.ORG)
CREATE USER 'MoeClub'@'%' IDENTIFIED BY 'MoeClub.ORG';

# 为用户(MoeClub)赋权访问数据库(DataBase)
GRANT ALL ON DataBase.* TO 'MoeClub'@'%';

# 刷新权限
FLUSH privileges;

# 删除用户(MoeClub)
DROP USER 'MoeClub'@'%';

```

# tty
```
AWS: console=ttyS0,115200
```

# Google Chrome CRX
```
https://clients2.google.com/service/update2/crx?response=redirect&prod=chromiumcrx&prodversion=100&acceptformat=crx3&x=installsource%3Dondemand%26uc%26id%3D<插件ID>

```

# SQLite3
```
CREATE TABLE `Table1` AS SELECT * FROM `Table0` WHERE 1=0;

INSERT INTO `Table1` SELECT DISTINCT * FROM `Table0`;

INSERT INTO `Table1` (字段1,字段2,.......) SELECT 字段1,字段2,...... FROM `Table0`;

DROP TABLE `Table0`;

ALTER TABLE `Table1` RENAME TO `Table0`;

```

# Oracle Loader Image
```
## console=tty1 console=ttyS0

# Create Image
dd if=/dev/sdb bs=32M status=progress |gzip -c9 >Oracle_ARM_47G_MoeClub.gz

# Apply Image
gzip -dc Oracle_ARM_47G_MoeClub.gz |dd of=/dev/sdb bs=32M status=progress

# Apply Image With Online
wget --no-check-certificate -qO- "<URL>" |gzip -dc |dd of=/dev/sdb bs=32M status=progress

```

# Aria2c
```
./aria2c --no-conf true --continue=true --file-allocation=falloc --disable-ipv6=true --enable-rpc=false --summary-interval=0 --split=65535 --min-split-size=8M --max-connection-per-server=16 -d <DIR> -o <FILE> "<URL>" 

# --ca-certificate=C:/ca-certificates.crt

```

# Linux Mount VHD
```
apt install -y libguestfs-tools

# Get vhd file disk part info
guestfish --ro -a <FilePath.vhd>
>run
>list-filesystems 
>exit

# Mount to read
guestmount --ro -a <FilePath.vhd> -m <DiskPart> <MountEndpoint>

```
# dpkg
```
# 修改文件时间
chmod -R 755 ocserv
find ocserv |xargs touch

# 打包
dpkg -b ocserv ocserv.deb

# 解包文件
dpkg -X ocserv.deb ocserv

# 解包控制信息
dpkg -e ocserv.deb ocserv/DEBIAN

```

# linux desktop
```
apt install -y xrdp gnome

```

# extend linux disk part
```
# fdisk, resize2fs
# 将硬盘从47G无损扩展到100G
1. `fdisk /dev/sda`
2. `p` 打印分区信息, 方便查看 sector 信息.
3. 对于每个旧分区 sector 信息都使用 `n` 创建新分区, 并且不移除分区签名.
4. `w` 保存分区信息.
5. `resize2fs -p /dev/sda2` 扩展到物理大小边界.
6. 修改 /etc/fstab 文件 (可选) 

```

# sshpass
```
mkdir -p "/tmp/sshpass"
curl -sSL "https://fossies.org/linux/privat/sshpass-1.09.tar.gz" |tar -zxv --strip-components=1 -C /tmp/sshpass 
cd /tmp/sshpass
./configure && make install

```

# bash string
```
# var 为变量名
获取变量长度: ${#var}
字符串截取: ${var:offset:length}
转换成大写: ${var^^}
转换成小写: ${var,,}

# pattern 支持 *, ?, [] 等
# string 可为空
头部最短匹配剔除: ${var#pattern}
头部最长匹配剔除: ${var##pattern}
尾部最短匹配剔除: ${var%pattern}
尾部最长匹配剔除: ${var%%pattern}
任意最短匹配替换: ${var/pattern/string}
任意最长匹配替换: ${var//pattern/string}

```

# OpenSSL 查看吊销列表
```
# 查看AlphaSSL证书吊销列表:
wget -qO- http://crl.globalsign.com/gsgccr6alphasslca2023.crl |openssl crl -inform DER -noout -text

# 利用 crt.sh 查看序列号对应的证书
https://crt.sh/?serial=<OpenSSL列出的序列号>

# 打印所有吊销的域名
for serial in `wget -qO- http://crl.globalsign.com/gsgccr6alphasslca2023.crl |openssl crl -inform DER -noout -text |grep 'Serial Number:' |cut -d':' -f2 |grep -o '[0-9a-zA-Z]\+'`; do cid=`wget -qO- "https://crt.sh/?serial=${serial}" |grep -o 'href="?id=[0-9]\+"' |cut -d'"' -f2`; wget -qO- "https://crt.sh/${cid}" |grep -o 'DNS:[^<]\+'; done

```

# KS-LE-1, Raid
```
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,FSTYPE,UUID
cat /etc/fstab
cat /proc/mdstat


# 从 md1 移除 sdb1
mdadm --manage /dev/md1 --fail /dev/sdb1
mdadm --manage /dev/md1 --remove /dev/sdb1

# 将 md1 转换成 Raid0
mdadm --grow /dev/md1 --level=0

# 卸载 md1
# umount /dev/md1
# mdadm --stop /dev/md1
# mdadm --zero-superblock /dev/sda1
# sed -i '/=md1$/d' /etc/mdadm.conf 


# 从 md2 移除 sdb2
mdadm --manage /dev/md2 --fail /dev/sdb2
mdadm --manage /dev/md2 --remove /dev/sdb2

# 将 md2 转换成 Raid0
mdadm --grow /dev/md2 --level=0

# 格式化 /dev/sdb, 分区格式为 raid
fdisk /dev/sdb

# 将 sdb2 添加进 md2, 状态从 Raid0 变为 Raid4， 同步完成后自动变为 Raid0
mdadm --grow /dev/md2 --level=0 --raid-devices=2 --add /dev/sdb1


# 查看 md2 详情
mdadm --misc --detail /dev/md2

# 重置 md2 容量
resize2fs /dev/md2

```

