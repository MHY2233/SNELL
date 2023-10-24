## 1.下载 Snell Server
    wget https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip
## 2.解压 Snell Server 到指定目录
    unzip snell-server-v4.0.1-linux-amd64.zip -d /usr/local/bin/
## 4.赋予服务器权限
    chmod +x /usr/local/bin/snell-server
## 5.编写配置文件：
    mkdir /etc/snell && curl -Lo /etc/snell/snell-server.conf https://raw.githubusercontent.com/MHY2233/snell-install/main/snell-server.conf
## 6.下载 systemctl 文件
    curl -Lo /etc/systemd/system/snell.service https://raw.githubusercontent.com/MHY2233/snell-install/main/snell.service && systemctl daemon-reload
## 7.开机运行 Snell
    systemctl enable snell
## 8.开启 Snell
    systemctl start snell
## 9.关闭Snell
    systemctl stop snell
## 11.查看 Snell 状态
    systemctl status snell


