# Container and Network

Create network.

```shell
❯ dn create my-net
98a8ddf0fcc7598bd7239397e94e0c5f69dd6a2b15865c6f5cb71251f8b6829f

❯ dn ls           
NETWORK ID     NAME      DRIVER    SCOPE
4ad73f92a88c   bridge    bridge    local
d4a1d345254a   host      host      local
98a8ddf0fcc7   my-net    bridge    local
eee761698bcb   none      null      local
```

Connect to server from another container by nslookup.

```shell
❯ dc run -d --name server --network my-net nginx
424f19b39f2fbe491a7c60539e67572dbdb9f3941a08d2500b097b38b6cd1cc0

❯ dc run -it --rm --name tool --network my-net ubuntu bash
root@132b057bd203:/# apt-get update
...
root@132b057bd203:/# apt-get install -y dnsutils
...
root@132b057bd203:/# nslookup server
Server:         127.0.0.11
Address:        127.0.0.11#53

Non-authoritative answer:
Name:   server
Address: 172.23.0.2
```

Connect to server from another container by curl.

```shell
root@132b057bd203:/# apt-get install -y curl
...
root@132b057bd203:/# curl http://server
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

Try connecting to container on another network. 

```shell
❯ dc run -it --rm --name bridge-tool ubuntu bash          
root@7ca077e47159:/# apt-get update && apt-get install -y dnsutils curl
...
root@7ca077e47159:/# nslookup server
Server:         192.168.65.5
Address:        192.168.65.5#53

** server can't find server: NXDOMAIN

root@7ca077e47159:/# nslookup 172.23.0.2
** server can't find 2.0.23.172.in-addr.arpa: NXDOMAIN

root@7ca077e47159:/# curl http://172.23.0.2
curl: (28) Failed to connect to 172.23.0.2 port 80: Connection timed out
```

# Awareness

- docker network is minimum network(?) 