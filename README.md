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

将下面的复制粘贴进去，按esc 后输入"：wq"保存退出
Tips 如果要进行修改，按“i”后移动光标到相应位置，进行修改完毕后按esc退出并输入“：wq”保存（这个说明给像我这样对vim不熟悉的）
[snell-server]
listen = 0.0.0.0:11807
psk = AijHCeos15IvqDZTb1cJMX5GcgZzIVE
ipv6 = false
参数说明：
listen：监听地址及端口； psk：密钥； ipv6：如果需要 IPv6 支持将值为 – true；

然后配置 Systemd 服务文件：
sudo vim /lib/systemd/system/snell.service
将下面的复制粘贴进去，按esc 后输入“：wq”保存退出

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
⚠️ 注意：在一些 Linux 发行版 (CentOS7) 中并无 nogroup 群组，但可以尝试修改成 Group=nobody 解决。如果需要使用特权端口，可以在 [Service] 增加一条：AmbientCapabilities=CAP_NET_BIND_SERVICE 以解决权限不足不能绑定的问题；

然后使用命令：

重载服务
sudo systemctl daemon-reload
开机运行 Snell
sudo systemctl enable snell
开启 Snell
sudo systemctl start snell
关闭 Snell
sudo systemctl stop snell
查看 Snell 状态

sudo systemctl status snell
Tips:运行查看服务器状态后按“q”键退出
如果要查看自己Snell配置：

cat /etc/snell/snell-server.conf
查看后将相应的配置输出到surge里面：

格式如下：（XXX.XXX.XXX.XXX换成你自己的vps IP，端口和psk也是自己改成自己设置的snell-server.conf里面相应数据。）

AWS-EC2-SG = snell, XXX.XXX.XXX.XXX, 11807, psk=AijHCeos15IvqDZTb1cJMX5GcgZzIVE, version=4, tfo=true
中午我是自己在 AWS -EC2 上按照这个步骤自己来了一遍并通了的。

如果你看完教程觉得好麻烦啊我不想动手搞，那么这个一键脚本应该可以帮到你
