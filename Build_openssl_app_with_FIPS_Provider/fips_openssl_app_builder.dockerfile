#use Debian bookworm

FROM debian:12.12

ARG OPENSSL_APP_VERSION=openssl-3.3.2
ARG OPENSSL_FIPS_VERSION=openssl-3.0.9

ENV OPENSSL_APP_VERSION=$OPENSSL_APP_VERSION
ENV OPENSSL_FIPS_VERSION=$OPENSSL_FIPS_VERSION

#build folder 
RUN mkdir /home/openssl 


#copy src files
COPY  ./src/buildOpensslApp.sh /home/openssl/src/

#build Open SSL
RUN chmod +x /home/openssl/src/buildOpensslApp.sh
RUN /home/openssl/src/buildOpensslApp.sh 

#clean build required packages
RUN apt remove -y wget original-awk make gcc perl binutils nano openssl

###configure openssl FIPS mode###

#copy FIPS src files for configuration
COPY  ./input/fips.so /home/openssl/src/
COPY  ./src/openssl.cnf /home/openssl/src/
COPY  ./src/installFipsModules.sh /home/openssl/src/


#install FIPS mode 
RUN chmod +x  /home/openssl/src/installFipsModules.sh
RUN /home/openssl/src/installFipsModules.sh

###### testing ######

# copy tests + permissions
COPY ./src/runTests.sh  /home/openssl/src/runTests.sh
RUN chmod +x /home/openssl/src/runTests.sh

#test  OpenSSL  and print to test file
RUN  /home/openssl/src/runTests.sh > /usr/local/ssl/OpenSS_FIPS_test_results.log

#clean install Folder
RUN rm -rf /home/openssl

# Set a working directory 
WORKDIR /home/

CMD ["/bin/bash"]







