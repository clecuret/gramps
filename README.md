# Goal

Main interests of this recipe is to managed gramps in docker.
The only element known by host is a docker image (for software) and  a docker volume (for configuration and data).

## Build

To build image, simply launch :
```
docker build -t gramps .
```

## Command to create volume named game-data :
```bash
docker create -v /home/developer/.gramps -v /home/developer/data.gpkg.media --name genealogy-data ubuntu:xenial /bin/true
```

folder .gramps is managed by gramps.

folder data.gpkg.media will contain your personal data




## Run

To launch docker container, a bash alias file is certainly the good option :

```bash
docker_localtime=" -v /etc/localtime:/etc/localtime "
docker_x=" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/home/developer/.Xauthority --net=host "
docker_me=" -e UID=`id -u` -e GID=`id -g`"

function gramps {
    docker run --name gramps $docker_x  --volumes-from genealogy-data $docker_me $docker_localtime -v /tmp:/data --rm -ti  gramps "$@"
}
```

The software will be launched by typing command : gramps

To obtain a backup of the whole database (with media) in /tmp, type : gramps gramps backup

A volume /data is necessary in container to request a backup
