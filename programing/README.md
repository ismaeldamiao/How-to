# Development Environment

In this text I show how to set up a development environment.

The *Development Environment* is a set of utilities and conventions
with the purpose to facilitate the software development (libraries, applications, etc...).

## Definitions

The *Development Environment* cosists of:

* A terminal running a POSIX compliant Shell Command Language, usually the Bash shell.
  * The following commands must have available:
    * All the mandatory commands standardized by POSIX.
    * All the BusyBox commands (if a command are in both, POSIX and BusyBox, then the POSIX is preferred).
    * `nano`.
* And the following conventions:
  1. The environment variable `DEV_HOME` point to a directory with permitions
     to read, write and execute.
  1. The directory `${DEV_HOME}/include` is reserved to symlinks to the interfaces of the libraries.
  1. The directory `${DEV_HOME}/lib` is reserved to symlinks to static and shared libraries,
     and any other kind of file that contain compiled libraries.
  1. The directory `${DEV_HOME}/bin` is reserved to symlinks to executable files.
  1. The directory `${DEV_HOME}/.packages` is reserved to the files of the installed packages.
  1. The directory `${DEV_HOME}/.projects` is reserved to source codes of projects.
     * Your preferred editor need to have access to `${DEV_HOME}/.projects`.

## Get started

The installation and configuration of the *Development Environment* can be very
simple.

* On Debian, Ubuntu, Android (under Termux), Windows (under WSL) and others
  you can simply use the commands:
  ```sh
  apt install -y coreutils busybox nano
  mkdir ${HOME}/dev
  cd ${HOME}/dev
  mkdir include lib bin .packages .projects
  ```
* Using `nano`, or other editor, put crate a file `${HOME}/dev/env.sh`
  with the content:
  ```sh
  #!/usr/bin/env sh
  
  # Set here the dev directory
  DEV_HOME="${HOME}/dev"
  
  # PATH
  export PATH="${DEV_HOME}/bin:${PATH}"
  ```

The `env.sh` script is to to set up the environment variables and need to be
loaded as:

```sh
. ~/dev/env.sh
```

For example, to start coding you open your shell and, before all, type:

```sh
. ~/dev/env.sh
cd "$DEV_HOME/.projects"
```

## Read more:

1. Set up programing languages with the *Development Environment*
   * [C](01-00_C.md)
   * [Lua](01-01_Lua.md)
   * [Java](01-01_Lua.md)
1. Set up software packing with the *Development Environment*
   * [Android](02-00_Android.md)

