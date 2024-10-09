#!/bin/bash

#In container not required ()set in dockerfile -  set last FIPS validated version
##export OPENSSL_FIPS_VERSION=openssl-3.0.9

cd $OPENSSL_FIPS_VERSION

#install fips mode
$openssl fipsinstall -module $OPENSSL_MODULES -out $fips_cnf -provider_name fips

mv $OPENSSL_CONF $OPENSSL_CONF.backup

#copy conf with default providers disable
cp /home/openssl/tests/openssl.cnf $OPENSSL_CONF

#add configuration  to openssl.cnf custom openssl.cnf

sed -i -e "s|<OPENSSL_MODULES>|$OPENSSL_MODULES|g" $OPENSSL_CONF

# echo module = $OPENSSL_MODULES >> $OPENSSL_CONF
# echo "" >> $OPENSSL_CONF
echo .include $fips_cnf >>$OPENSSL_CONF

$openssl list -providers
