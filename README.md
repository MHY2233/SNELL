# 手动配置
## 1.安装工具
    apt update 
    apt install vim -y
    apt install unzip

## 2.下载 Snell Server
    wget https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-amd64.zip

## 3.解压 Snell Server 到指定目录
    unzip snell-server-v4.0.1-linux-amd64.zip -d /usr/local/bin/

## 4.赋予服务器权限
    chmod +x /usr/local/bin/snell-server
## 5.编写配置文件：

### 5.1先执行新建文件夹操作
    mkdir /etc/snell

#### 5.1.1 可以直接下载配置(方式一)
    curl -Lo /etc/snell/snell-server.conf https://raw.githubusercontent.com/MHY2233/snell-install/main/snell-server.conf_server.json

#### 5.1.2可以使用 Snell 的 wizard 生成一个配置文件(方式二)
    snell-server --wizard -c /etc/snell/snell-server.conf

#### 5.1.3或者自己编写一个(方式三)
    vim /etc/snell/snell-server.conf
```bash
[snell-server]
listen = 0.0.0.0:12321
psk = AijHCeos15IvqDZTb1cJMX5GcgZzIVE
obfs = http
ipv6 = false
```

## 6.配置 Systemd 服务文件

### 6.1下载service文件(方式一)
    curl -Lo /etc/systemd/system/snell.service https://raw.githubusercontent.com/MHY2233/snell-install/main/snell.service && systemctl daemon-reload
    
### 6.2或者手动配置service文件(方式二)

    vim /lib/systemd/system/snell.service

### 将下面的复制粘贴进去，按esc 后输入“：wq”保存退出
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


