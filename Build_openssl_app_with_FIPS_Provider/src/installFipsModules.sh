#!/bin/bash

#cd to working dir
cd /home/openssl/

#declare OpenSSL Vars
export openSSLDir=/usr/local/ssl
export OPENSSL_CONF=$openSSLDir/openssl.cnf
export OPENSSL_MODULES=$openSSLDiropenssl/fips.so
export fips_cnf=$openSSLDir/fips.cnf
export openssl=/usr/local/ssl/bin/openssl

#copy OpenSSL Providers
cp /home/openssl/src/fips.so $OPENSSL_MODULES

#install fips mode
openssl fipsinstall -module $OPENSSL_MODULES -out $fips_cnf -provider_name fips

mv $OPENSSL_CONF $OPENSSL_CONF.backup

#copy conf with default providers disable
cp /home/openssl/src/openssl.cnf $OPENSSL_CONF

#add configuration  to openssl.cnf custom openssl.cnf

sed -i -e "s|<OPENSSL_MODULES>|$OPENSSL_MODULES|g" $OPENSSL_CONF

# echo module = $OPENSSL_MODULES >> $OPENSSL_CONF
# echo "" >> $OPENSSL_CONF
echo .include $fips_cnf >>$OPENSSL_CONF
