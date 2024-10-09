#!/bin/bash

# # required OPENSSL_FIPS_VERSION Var - set in main bash
# export  OPENSSL_FIPS_VERSION=openssl-3.0.9

echo Building open ssl fips app From OpenSSL version:$OPENSSL_APP_VERSION and fips provider version $OPENSSL_FIPS_VERSION

cd Build_openssl_app_with_FIPS_Provider

export FipsAppBuilderImage=openssl-fips_app_builder:$OPENSSL_APP_VERSION
export FipsAppBuilderContainer=openssl-fips_app_builder-$OPENSSL_APP_VERSION

#Build openssl app builder container
docker build -t $FipsAppBuilderImage -f fips_openssl_app_builder.dockerfile \
   --build-arg OPENSSL_APP_VERSION_ARG=$OPENSSL_APP_VERSION \
   --build-arg OPENSSL_FIPS_VERSION_+ARG=$OPENSSL_FIPS_VERSION .

# #Run container
# docker run -it  $FipsAppBuilderImage

#create Container
docker rm -f $FipsAppBuilderContainer 2>/dev/null

docker create --name $FipsAppBuilderContainer $FipsAppBuilderImage

export now=$(date +"%Y-%m-%dT%H:%M:%S")
export logFileName=OpenSSL_test_results_$now.log
#import FIPS Provider from container
echo creating temp container
docker cp $FipsAppBuilderContainer:/usr/local/ssl/OpenSS_FIPS_test_results.log ./output/$logFileName

echo cleaning temp container
docker rm -f $FipsAppBuilderContainer

cat ./output/$logFileName

echo $$$$ FipsAppImage=FipsAppBuilderImage $$$$
