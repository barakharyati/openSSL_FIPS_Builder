#!/bin/bash

export now=$(date +"%Y-%m-%dT%H:%M:%S")

echo creation date = $now

echo testing FIPS Provider Modules Version:$OPENSSL_FIPS_VERSION

#print to log
echo ----openssl version -a----
openssl version -a

echo ----openssl list -providers----
openssl list -providers

# Check if FIPS mode is active
echo "Checking if FIPS mode is active:"
FIPS_STATUS=$(openssl list -providers | grep fips)

if [[ "$FIPS_STATUS" == *"fips"* ]]; then
    echo "Successes FIPS mode providers returned"
else
    echo "FIPS mode is not enabled. Ensure that the correct fips.so is being used."
    exit 1
fi

# Test file
TEST_FILE="/etc/hosts"

#check if SHA 256 ius working
echo "Testing SHA256 is working"
openssl sha256 $TEST_FILE 2>/dev/null
if [ $? -eq 0 ]; then
    echo "SHA256 succeeded OpenSSL is working"

else
    echo "SHA256 failed (something is wrong)"
    exit 1
fi

echo "Testing MD5 hash (should fail in FIPS mode):"
openssl md5 $TEST_FILE 2>/dev/null
if [ $? -eq 0 ]; then
    echo "MD5 succeeded (FIPS not enforced)"
    exit 1
else
    echo "MD5 failed (FIPS mode is active)"
fi

echo "all tests complete successfully"
