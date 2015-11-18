#!/bin/sh -eux
# docker-provision.sh --- Provisioning script for a Docker container w/Aglio.
AGLIO_VERSION="2.2.0"
FONT_AWESOME_VERSION="4.4.0"


# General packages needed to build Node modules. This list is based on the list
# in https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile
BUILD_PKGS="autoconf automake bzip2 file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev libevent-dev libffi-dev libgeoip-dev libglib2.0-dev libjpeg-dev liblzma-dev libmagickcore-dev libmagickwand-dev libmysqlclient-dev libncurses-dev libpng-dev libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev libyaml-dev make patch xz-utils zlib1g-dev"

# update Apt repositories
apt-get update


# install curl
apt-get install -y --no-install-recommends ca-certificates curl


# install build packages
apt-get install -y --no-install-recommends $BUILD_PKGS


# install Aglio
npm install -g aglio@$AGLIO_VERSION


# Download font awesome
apt-get install -y --no-install-recommends unzip
mkdir -p /aglio/assets
cd /aglio/assets
curl -O -j https://fortawesome.github.io/Font-Awesome/assets/font-awesome-$FONT_AWESOME_VERSION.zip
unzip font-awesome-$FONT_AWESOME_VERSION.zip
mv font-awesome-$FONT_AWESOME_VERSION/css /aglio/assets
mv font-awesome-$FONT_AWESOME_VERSION/fonts /aglio/assets
rm -r font-awesome-$FONT_AWESOME_VERSION*


# remove installation dependencies
apt-get -y purge curl ca-certificates unzip $BUILD_PKGS
apt-get -y autoremove
rm -rf /var/lib/apt/lists/* /root/.npm


# Add empty docs directory
mkdir -p /docs
