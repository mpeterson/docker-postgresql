FROM phusion/baseimage:0.9.10
MAINTAINER mpeterson <docker@peterson.com.ar>

# Make APT non-interactive
ENV DEBIAN_FRONTEND noninteractive

# Ensure UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Change this ENV variable to skip the docker cache from this line on
ENV LATEST_CACHE 2014-05-01T22:00-03:00

# Upgrade the system to the latest version
RUN apt-get update
RUN apt-get upgrade -y

# Install packages needed for this image
RUN apt-get install -y --force-yes postgresql-contrib postgresql

# This after the package installation so we can use the docker cache
RUN mkdir /build
ADD . /build

# Starting the installation of this particular image

# Recreate the cluster in UTF-8, allow external connections, create
# new user and modify the location of the data
VOLUME ["/data"]
ENV DATA_DIR /data
RUN /build/prepare_postgres.sh

EXPOSE 5432
EXPOSE 22

# End of particularities of this image

# Give the possibility to override any file on the system
RUN cp -R /build/overrides/. /

# Add services
RUN cp -R /build/runit/. /etc/service/

# Clean everything up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build

CMD ["/sbin/my_init"]
