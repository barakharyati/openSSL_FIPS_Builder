#!/bin/bash

#cd to working dir
cd /home/openssl/

#apt update and install required packages
apt update

apt install -y wget original-awk make gcc perl binutils wget nano
#get openssl

#download openssl
echo OPENSSL_APP_VERSION:$OPENSSL_APP_VERSION
wget https://www.openssl.org/source/$OPENSSL_APP_VERSION.tar.gz
tar -xvzf $OPENSSL_APP_VERSION.tar.gz
cd $OPENSSL_APP_VERSION

#configure make
./Configure --prefix=/usr/local/ssl --openssldir=/usr/local/ssl no-shared linux-x86_64

./Configure no-shared linux-x86_64

#build openssl fips
make -j8

#install OpenSSL App
make install
