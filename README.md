# docker-hs

Setup Hearthstone with wine inside a docker container.

## Prerequisites

* Docker installed
* Battle.net account
* Xorg desktop


The provided scripts use docker commands, that require the user to
have permissions to use docker, i.e. the user has to be part of the
docker group. If this is not the case, you will need to execute the
scripts with superuser privileges, e.g. `sudo`.

## Setup docker image

To setup the image, use the provided script. This will first create the docker
image with all needed dependencies.

```
./create_docker_image.sh
```

After this is done successfully, the script will start the blizzard app setup.
Just apply all default settings during the installation process. When this is
finished, the Blizzard app will open. Select hearthstone and install it to the
default location. After the hearthstone installation is finished, don't start
the game yet. First exit/close the blizzard app.

Finally, the script will commit all changes to the container to the image and
delete the container. That way, if you need to reset the container, you can
just delete it and start it anew from the image.


## Running things

#### Start Hearthstone

You can start hearthstone from inside the Battle.net app. To run the app, run:

```
run_app.sh
```

#### Update Hearthstone

Updates of the Battle.net client and Hearthstone are handled by the
Battle.net client.

#### Update packages

To do an upgrade of the system inside the container without re-creating the
whole container, run:

```
run_system_upgrade.sh
```

#### Bash shell

If you want to do something else like inspecting the container or add
packages to the image or change some wine settings, you can start an
interactive shell with this command:

```
./run_bash.sh
```

#### Stop the container

To stop the container, run:

```
./stop.sh
```
