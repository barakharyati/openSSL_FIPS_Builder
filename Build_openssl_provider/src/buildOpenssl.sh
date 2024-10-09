#!/bin/bash

#cd to working dir
cd /home/openssl/

#In container not required ()set in dockerfile -  set last FIPS validated version
##export OPENSSL_FIPS_VERSION=openssl-3.0.9

#apt update and install required packages
apt update

apt install -y wget original-awk make gcc perl binutils nano
#get openssl

#download openssl
echo OPENSSL_FIPS_VERSION:$OPENSSL_FIPS_VERSION
wget https://www.openssl.org/source/$OPENSSL_FIPS_VERSION.tar.gz
tar -xvzf $OPENSSL_FIPS_VERSION.tar.gz
cd $OPENSSL_FIPS_VERSION

#configure make
./Configure enable-fips no-shared linux-x86_64

#build openssl fips
make -j8
