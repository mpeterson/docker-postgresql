# mpeterson/postgresql
## Features
  * External data volume
  * Allow to override or add files to the image when building it.

## Usage
This example considers that you have a [data-only container](http://docs.docker.io/use/working_with_volumes/) however it's not needed for it to run correctly.

```bash
sudo docker run -d --volumes-from pgsql_data --name pgsql mpeterson/postgresql
```

Since the idea is to use this linked with another container the Postgresql port is not exposed in the previous example.

### Default DB User
By default this image creates the following user with superadmin:

  * **User:** ```admin```
  * **Pass:** ```admin```

It is not recommended to leave this user with the default password. To change it connect to the postgresql server and issue the following command:

```postgresql
ALTER USER admin WITH PASSWORD '<new_password>';
```

### Volumes
  * ```/data``` volume is where your sites should be contained. This path has a symlink as ```/var/www``` to respect standards. Can be overriden via environmental variables.

It is recommended to use the [data-only container](http://docs.docker.io/use/working_with_volumes/) pattern and if you choose to do so then the volumes that it needs to have is ```/data```.

### Override files
In the case that the user wants to add files or override them in the image it can be done stated on this section. This is particularly useful for example to add a cronjob or add certificates.

Since docker 0.10 removed the command ```docker insert``` the image needs to be built from source.

For this a folder ```overrides/``` inside the path ```image/``` can be created. All files from there will be copied to the root of the system. So, for example, putting the following file ```image/overrides/etc/ssl/certs/cloud.crt``` would result in that file being put on ```/etc/ssl/certs/cloud.crt``` on the final image.

After that just run ```sudo make``` and the image will be created.

## Configuration
Configuration options are set by setting environment variables when running the image. This options should be passed to the container using docker
```-e <variable>```. What follows is a table of the supported variables:

Variable     | Function
------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------
DATA_DIR     | Allows to configure where the path that will hold the files. Bear in mind that since the Dockerfile has this hardcoded so it might be neccesary to build from source
