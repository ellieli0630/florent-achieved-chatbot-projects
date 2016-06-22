cd ~/florent-server
NET_IF=`netstat -rn | awk '/^0.0.0.0/ {thif=substr($0,74,10); print thif;} /^default.*UG/ {thif=substr($0,65,10); print thif;}'`
NET_IP=`ifconfig ${NET_IF} | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`

sudo docker build -t florent-docker .

sudo docker kill $(sudo docker ps -q)

sudo docker run -d -v /var/lib/postgresql/9.3/main -p 0.0.0.0:80:80 -t florent-docker
