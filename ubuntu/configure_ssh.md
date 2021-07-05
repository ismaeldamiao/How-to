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

Host redmi
   hostname 192.168.0.3
   Port 2225
```

Obs.: `redmi` is an alias to the server hosted in `192.168.0.3`,
to connect to it type `ssh redmi` in the client ssh terminal
instead `ssh -P 2225 192.168.0.3`.

## Setup a key

You can use keys to connect a ssh host without type the password.
In the server type `ssh-keygen` to generate a new key and in the client
type `ssh-copy-id -i server_alias` to copy the key.
