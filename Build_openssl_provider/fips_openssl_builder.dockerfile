#use Debian bookworm

FROM debian:12.13
ARG OPENSSL_FIPS_VERSION=openssl-3.0.9

ENV OPENSSL_VERSION=$OPENSSL_FIPS_VERSION

ENV outputFolder=/home/openssl/output

#build folder 
RUN mkdir /home/openssl 

#create output DIR
RUN mkdir $outputFolder


# Set a working directory 
WORKDIR /home/openssl

#copy source files ${OPENSSL_FIPS_VERSION}
COPY ./src  /home/openssl/src
RUN ls /home/openssl/src

#build Open SSL
RUN chmod +x /home/openssl/src/buildOpenssl.sh
RUN /home/openssl/src/buildOpenssl.sh 

###### testing ######


#declare testing vars
ENV OpenSSLDir=/home/openssl/$OPENSSL_VERSION
ENV openssl=$OpenSSLDir/apps/openssl
ENV OPENSSL_CONF=$OpenSSLDir/apps/openssl.cnf
ENV OPENSSL_MODULES=$OpenSSLDir/providers/fips.so
ENV fips_cnf=$OpenSSLDir/apps/fips.cnf


# copy tests + permissions
RUN echo building env 
COPY ./tests  /home/openssl/tests
RUN chmod +x /home/openssl/tests/buildTestEnv.sh
RUN chmod +x /home/openssl/tests/runTests.sh

#build testing env 
RUN  /home/openssl/tests/buildTestEnv.sh

#test  OpenSSL  and print to test file
RUN  /home/openssl/tests/runTests.sh > $outputFolder/OpenSSL_test_results.log

CMD ["/bin/bash"]







