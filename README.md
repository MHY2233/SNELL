### 1.下载 Snell Server 安装包
    wget https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip
### 2.解压 Snell Server 到指定目录
    unzip snell-server-v4.0.1-linux-amd64.zip -d /usr/local/bin/
### 3.赋予服务器权限
    chmod +x /usr/local/bin/snell-server
## 4.下载配置文件：
    mkdir /etc/snell && curl -Lo /etc/snell/snell-server.conf https://raw.githubusercontent.com/MHY2233/snell-install/main/snell-server.conf
## 5.下载 systemctl 文件
    curl -Lo /etc/systemd/system/snell.service https://raw.githubusercontent.com/MHY2233/snell-install/main/snell.service && systemctl daemon-reload
## 6.开启 snell 服务
    systemctl start snell
## 7.设置 snell 开机启动
    systemctl enable snell
## 8.查看 Snell 状态
    systemctl status snell
## 9.删除安装包
    rm ~/snell-server-v4.0.1-linux-amd64.zip


