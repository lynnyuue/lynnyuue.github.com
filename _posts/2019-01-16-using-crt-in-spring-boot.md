---
layout: post
title: "using crt in spring boot"
description: "add ssl certificate in spring boot application"
category: java
tags: [spring, ssl]
---

According to the security policy requirements, we need to enable the https protocol and add ssl certificate.

# apply new certificate

using [sslforfree](https://www.sslforfree.com/) apply for a free certificate

> this require a validate domain at the first

1. https://www.sslforfree.com/create?domains=[domain]
2. Manually Verify Domain
3. Upload Verification Files
4. Download SSL Certificate


# convert certificate to p12 format

1. create public and private key in server

    ```bash
    openssl pkcs12 -export -clcerts -in certificate.crt -inkey private.key -out server.p12
    ```
    
    > the password is required in this step, do not forgot it

2. search key alias

    ```bash
    keytool -list -keystore server.p12
    Enter keystore password: [pwd]
    Keystore type: jks
    Keystore provider: SUN
    
    Your keystore contains 1 entry
    
    1, Jan 16, 2019, PrivateKeyEntry,
    Certificate fingerprint (SHA1): xxxxxx
    ```

3. put server.p12 to jar folder and modify application.properties

    ```java
    server.ssl.key-store=server.p12
    server.ssl.key-store-password=[pwd]
    server.ssl.key-store-type=PKCS12
    server.ssl.key-alias=1
    ```