#!/bin/bash

# # required OPENSSL_FIPS_VERSION Var - set in main bash
# export  OPENSSL_FIPS_VERSION=openssl-3.0.9

echo Building fips Provider From OpenSSL version:$OPENSSL_FIPS_VERSION

cd Build_openssl_provider

#clean FipsProviderBuilder Folder
rm -f ./output/*.*

export FipsProviderBuilderImage=openssl-fipsbuilder:$OPENSSL_FIPS_VERSION
export FipsProviderBuilderContainer=openssl-fipsbuilder-$OPENSSL_FIPS_VERSION

#Build container
docker build -t $FipsProviderBuilderImage -f fips_openssl_builder.dockerfile --build-arg OPENSSL_FIPS_VERSION=$OPENSSL_FIPS_VERSION .

# #Run container
# docker run -it  $builderImageName

#create Container
docker rm -f $FipsProviderBuilderContainer 2>/dev/null
docker create --name $FipsProviderBuilderContainer $FipsProviderBuilderImage

export now=$(date +"%Y-%m-%dT%H:%M:%S")
export logFileName=OpenSSL_test_results_$now.log
#import FIPS Provider from container
docker cp $FipsProviderBuilderContainer:/home/openssl/output/OpenSSL_test_results.log ./output/$logFileName

#Import FIPS Provider test log from Container
docker cp $FipsProviderBuilderContainer:/home/openssl/output/fips.so ./output

docker rm -f $FipsProviderBuilderContainer

ls output/fips.so
FIPS_STATUS=$($ls output/fips.so)

FILE=output/fips.so
if [ -f $FILE ]; then
   echo "------ Success: File $FILE exists. ------"
else
   echo "----- Success: File $FILE does not exist. ------"
fi

echo "-------- Fips test results -----------"
cat output/$logFileName
echo "-------- End Of Fips test results -----------"
