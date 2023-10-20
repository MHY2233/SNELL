## 1.更新系统
    apt update && apt -y install vim && apt install unzip

## 2.下载 Snell Server
    wget https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip

## 3.解压 Snell Server 到指定目录
    unzip snell-server-v4.0.1-linux-amd64.zip -d /usr/local/bin/

## 4.赋予服务器权限
    chmod +x /usr/local/bin/snell-server
## 5.编写配置文件：
先执行新建文件夹操作
mkdir /etc/snell

### 5.1可以使用 Snell 的 wizard 生成一个配置文件
    snell-server --wizard -c /etc/snell/snell-server.conf

### 5.2或者自己编写一个
    vim /etc/snell/snell-server.conf
```bash
[snell-server]
listen = 0.0.0.0:12321
psk = AijHCeos15IvqDZTb1cJMX5GcgZzIVE
ipv6 = false
```

## 6.配置 Systemd 服务文件
    vim /lib/systemd/system/snell.service
### 6.1将下面的复制粘贴进去，按esc 后输入“：wq”保存退出
```bash
[Unit]
Description=Snell Proxy Service
After=network.target

[Service]
Type=simple
User=nobody
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

## 7.重载服务
    systemctl daemon-reload
## 8.开机运行 Snell
    systemctl enable snell
## 9.开启 Snell
    systemctl start snell
## 10.关闭Snell
    systemctl stop snell
## 11.查看 Snell 状态
    systemctl status snell

