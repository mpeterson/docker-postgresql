#!/bin/bash
VERSION=`pg_lsclusters -h|awk '{print $1}'`

if [[ ! "$(ls -A $DATA_DIR)" ]]; then
    cp -a /var/lib/postgresql/$VERSION/main/. $DATA_DIR
fi

if [ ! -e '/var/log/postgresql' ]; then
    mkdir /var/log/postgresql
fi

su postgres -c "/usr/lib/postgresql/$VERSION/bin/postgres -D $DATA_DIR \
    -c config_file=/etc/postgresql/$VERSION/main/postgresql.conf"
