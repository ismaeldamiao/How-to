# Install Python

Uncomment all `deb-src` in `/etc/apt/sources.list`

```bash
nano /etc/apt/sources.list
```

Install headers and librearies

```bash
apt build-dep python3
apt install -y pkg-config
apt install -y build-essential gdb lcov pkg-config \
   libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
   libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
   lzma lzma-dev tk-dev uuid-dev zlib1g-dev
```

Download the latest release of python at
[Official Python website](https://www.python.org/downloads/)
and uncompress with `tar -xf`.

```bash
./configure
make
make altinstall # As root
```