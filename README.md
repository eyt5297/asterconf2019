# asterconf2019
final doc
## обо мне
Евгений Тевелевич

tg: @eyt5297
tg: @chan_asterisk


## Общая подготовка для двух хостов

Создаем два хоста CentoOS 7

### отключаем SELINUX
setenforce 0
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config

### Установка дополнительных пакетов
yum install -y vim tmux tcpdump nmap net-tools git mc tree 

### sngrep 
 echo "[irontec]" > /etc/yum.repos.d/irontec.repo 
 echo "name=Irontec RPMs repository" >> /etc/yum.repos.d/irontec.repo 
 echo "baseurl=http://packages.irontec.com/centos/\$releasever/\$basearch/" >> /etc/yum.repos.d/irontec.repo 
 rpm --import http://packages.irontec.com/public.key
 yum install sngrep -y

### iptables 
 sudo yum -y install iptables-services
 systemctl stop firewalld
 systemctl disable firewalld
 sudo systemctl enable iptables.service
 sudo systemctl start iptables.service
 vim /etc/sysconfig/iptables
 sudo service iptables restart
 sudo systemctl restart iptables.service

### Docker
yum install -y docker
systemctl enable docker
systemctl start docker


## подготовка pbx_1

mkdir /opt/store && cd /opt/store

git clone https://github.com/eyt5297/asterconf2019.git 

cd pbx-test1

### Скачиваем образ
docker pull eyt5297/asterisk16

### проверяем наличие образа
docker images

### запскаем контейнер cd /opt/store/pbx-test1 
docker run -it -v $(pwd)/var/spool/asterisk/monitor:/var/spool/asterisk/monitor -v $(pwd)/var/log/asterisk:/var/log/asterisk -v $(pwd)/var/log/asterisk/cdr-csv:/var/log/asterisk/cdr-csv -v $(pwd)/etc/asterisk:/etc/asterisk --net=host -h pbx_1-docker --name pbx1 eyt5297/asterisk16

нажимаем последовательность Ctrl+p, Ctrl+q , чтобы отключиться от контейнера

### проверяем наличие и статус контейнера
docker ps -a

##### остановить контейнер можно 
docker stop pbx1
или
docker attach pbx1 

core stop now

### запустить остановленный 
docker start pbx1

### присоеденится к контейнеру 
docker exec -it  pbx1 /bin/bash




## подготовка pbx_2

mkdir /opt/store && cd /opt/store

git clone https://github.com/eyt5297/asterconf2019.git 
 
cd pbx-test2

### Скачиваем образ
docker pull eyt5297/asterisk16

### проверяем наличие образа
docker images

### запскаем контейнер cd /opt/store/pbx-test2 
docker run -it -v $(pwd)/var/spool/asterisk/monitor:/var/spool/asterisk/monitor -v $(pwd)/var/log/asterisk:/var/log/asterisk -v $(pwd)/var/log/asterisk/cdr-csv:/var/log/asterisk/cdr-csv -v $(pwd)/etc/asterisk:/etc/asterisk -v $(pwd)/pbxtest:/opt/store/pbxtest --net=host -h pbx_2-docker --name pbx2 eyt5297/asterisk16 

нажимаем последовательность Ctrl+p, Ctrl+q , чтобы отключиться от контейнера

### проверяем наличие и статус контейнера
docker ps -a

### остановить контейнер можно 
docker stop pbx2
или
docker attach pbx2 

core stop now

### запустить остановленный 
docker start pbx2

### присоеденится к контейнеру 
docker exec -it pbx2 /bin/bash


#поменять ip адрес во всех файла конфигурации

find ./ -type f -exec sed -i -e 's/old_ip_or_domain/new_ip_or_domain/g' {} \;


find ./ -type f -exec sed -i -e 's/hzpbx.abovomed.com/116.202.25.254/g' {} \;
