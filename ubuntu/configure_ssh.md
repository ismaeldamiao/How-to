# How to configure shh

In this text I show how to install and configure a `ssh` server and client
and how to make a private key.

To install `ssh` type in terminal:

```bash
apt install ssh # in Ubuntu
apt install openssh # in Termux
```

## Setup a ssh server

Configure a ssh server is easy, the setings are in `/etc/ssh/sshd_config`
(`$PREFIX/etc/ssh/sshd_config` in termux).
A simple setting is:

```
Port 22
PasswordAuthentication yes
UseDNS no
ClientAliveInterval 60
ClientAliveCountMax 10000
```

## Setup the client

You can configure the client in `~/.ssh/config`.
You can configure various ssh hosts, the host `*` is the default.

```
Host *
   AddressFamily inet
   Compression yes
   ForwardX11 no
   ServerAliveInterval 60
   ServerAliveCountMax 10

Host if
   hostname 200.17.113.231
   user ismael
   ForwardX11 yes
   Port 22

Host moto
   hostname 192.168.0.2
   Port 2225

Host redmi
   hostname 192.168.0.3
   Port 2225
```

Obs.: `if` is an alias to the server hosted in `200.17.113.231`,
to connect to it type `ssh if` in the client ssh terminal
instead `ssh -P 22 ismael@200.17.113.231`.

## Setup a key

You can use keys to connect a ssh host without type the password.
In the server type `ssh-keygen` to generate a new key and in the client
type `ssh-copy-id -i server_alias` to copy the key.
