#!/bin/bash

#add the required OpenSSL Version

#open ssl fips validated version - you can check last fips validated version here https://openssl-library.org/source/
export OPENSSL_FIPS_VERSION=openssl-3.0.9
#open ssl application version you should use select supported version with you openssl version
export OPENSSL_APP_VERSION=openssl-3.3.2

#clean temp files
rm -f ./Build_openssl_app_with_FIPS_Provider/input/*.*
rm -f ./Build_openssl_app_with_FIPS_Provider/output/*.*
rm -f ./Build_openssl_provider/output/*.*

export rootFolder=$(pwd)
export now=$(date +"%Y-%m-%dT%H:%M:%S")

#build Fips Providers
chmod +x ./Build_openssl_provider/build_fips_provider.sh
./Build_openssl_provider/build_fips_provider.sh

#copy fips providers file to openssl app builder
cp ./Build_openssl_provider/output/fips.so ./Build_openssl_app_with_FIPS_Provider/input/fips.so

#build open ssl app with fips provider

./Build_openssl_app_with_FIPS_Provider/build_openssl_FIPS_app.sh
