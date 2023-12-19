- **1.下载 Snell Server 安装包**
    wget https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip
- **2.解压 Snell Server 到指定目录**
    unzip snell-server-v4.0.1-linux-amd64.zip -d /usr/local/bin/
- **3.赋予服务器权限**
    chmod +x /usr/local/bin/snell-server
- **4.创建配置文件**
    mkdir /etc/snell

    vim /etc/snell/snell-server.conf

**写入下面内容**
```bash
[snell-server]
listen = 0.0.0.0:12321
psk = thezuiniubidepassword
Obfs = http
ipv6 = true
```
- **5.配置systemctl 文件**
    vim /etc/systemd/system/snell.service

**写入下面内容**
```bash
[Unit]
Description=Snell Proxy Service
After=network.target

[Service]
Type=simple
User=root
Group=nogroup
LimitNOFILE=32768
ExecStart=/usr/local/bin/snell-server -c /etc/snell/snell-server.conf
AmbientCapabilities=CAP_NET_BIND_SERVICE
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=snell-server

[Install]
WantedBy=multi-user.target
```
- **6.开启 snell 服务**
    systemctl start snell
- **7.设置 snell 开机启动**
    systemctl enable snell
- **8.查看 Snell 状态**
    systemctl status snell
- **9.删除安装包**
    rm ~/snell-server-v4.0.1-linux-amd64.zip
