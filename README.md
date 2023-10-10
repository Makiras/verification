# container-xrdp

Docker container for [xrdp](http://xrdp.org/) (both [Xorg](https://github.com/neutrinolabs/xorgxrdp) and [Xvnc](https://tigervnc.org/)) currently based on [Ubuntu](https://ubuntu.com/).

Full desktop environments [Xfce](https://www.xfce.org/) are supported. No privilege or sys_cap is required on the host system. These containers are lightweight and ideal for rapid development and testing purposes. Notice that the state of the container is not persisted between runs. 

In order to persist the state of the container, see [this guide](https://stackoverflow.com/questions/44480740/how-to-save-a-docker-container-state).

## How to use

### Docker ENV

First pull the container with the appropriate tag. the following tag combinations are available:

- ghcr.io/makiras/verification:sx-synopsys-focal
    + ssh, rdp, synopsys vcs+verdi **only dependencies** for ubuntu focal

Example:

```bash
docker pull ghcr.io/makiras/verification:sx-synopsys-focal
```

You have to give username, password, and sudo ability as input arguments to the docker run command. Hence, each user has three parameters. The process will exit if the input arguments are incorrect. Please run as interactive mode at first instance.

Example when username is _foo_, password is _bar_ and sudo ability is _yes_:

```bash
run -d --init -v $workdir:/data --name xrdpvcs --hostname xrdpvcs --mac-address 00:be:43:11:45:14 --privileged  -p 9389:3389 -p 9022:22 makiras/verification:sx-synopsys-focal foo bar yes
```

Once running, open Remote Desktop Connection. Enter "ip_addr:9389" as the address, and ssh port is 9022.

In this example username is _foo_ and the password is _bar_.

### VCS ENV

1.  `--hostname xrdpvcs --mac-address 00:be:43:11:45:14` is required for synopsys vcs license. If you want to use my synosys packge, **DO NOT CHANGE IT** !
2.  `-v $workdir:/data` is used to mount your workdir to `/data` in container. The path `/data/synopsys` and its structural is **hard coded** in my package.  Your $workdir MUST have a folder named `synopsys` and its structural is as follows.

    ```bash
    tree -L 2 synopsys/
    synopsys/
    ├── env.sh
    ├── installer
    │   ├── batch_installer
    │   ├── container
    │   ├── container_setup.sh
    │   ├── doc
    │   ├── install_bin
    │   ├── installer
    │   ├── installer.log
    │   └── setup.sh
    ├── license
    │   └── Synopsys.dat
    ├── scl
    │   ├── 2018.06
    │   ├── gen-snpslmd-hack.c
    │   └── snpslmd-hack.so
    ├── vcs
    │   └── O-2018.09-SP2
    └── verdi
        └── Verdi_O-2018.09-SP2
    ```
    I will `ln -s /data/synopsys/env.sh /etc/profile.d/99-synopsys.sh`, so change it by your self if you want to use your own synopsys package.
3. Your  `$workdir` UID and GID MUST be included by container's users' UIDs and GIDs. Usually, it is 1000. You can check it by `id -u` **out of container**. If not, you can change it by `usermod -u $your_uid $your_username` and `groupmod -g $your_gid $your_groupname` **in container**.


###  SYNOPSYS package

```bash
mkdir -p workdir && cd workdir

wget $synopsys_package_url -O synopsys.tar.bz2
pbzip2 -d -p8 -k synopsys.tar.bz2 && tar -xf synopsys.tar

pwd # this is your $workdir
```

###  Adding more users

You can add more users as a list of arguments and 3 inputs per user as described above

Example:
| User | Pass | Sudo |
|---|:---:|---:|
| foo | bar | yes |
| baz | cox | no |

```bash
docker run -it -p 33890:3389 ${OTHER_OPTIONS} makiras/verification:sx-synopsys-focal foo bar yes baz qux no
```


## Build & Contributions

Check the following [guide](build.md) for building your own containers.

## Contributions

Main part of this repo is forked from [danchitnis/container-xrdp](danchitnis/container-xrdp), and I add some synopsys dependencies for ubuntu focal.

Inspired by [frxyt/docker-xrdp](https://github.com/frxyt/docker-xrdp)

Ubuntu commands by [danielguerra69/ubuntu-xrdp](https://github.com/danielguerra69/ubuntu-xrdp/)

xrdp service restrat by [timwa0669](https://github.com/timwa0669)
