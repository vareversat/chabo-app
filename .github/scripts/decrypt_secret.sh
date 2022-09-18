#!/bin/bash

# Decrypt keystore.jks.gpg
gpg --batch --yes --decrypt --pinentry-mode loopback --passphrase="$PASSPHRASE" --output "$GITHUB_WORKSPACE"/android/app/keystore.jks "$GITHUB_WORKSPACE"/encrypted_config/keystore.jks.gpg
# Decrypt fastlane-key.json.gpg
gpg --batch --yes --decrypt --pinentry-mode loopback --passphrase="$PASSPHRASE" --output "$GITHUB_WORKSPACE"/android/fastlane/fastlane-key.json "$GITHUB_WORKSPACE"/encrypted_config/fastlane-key.json.gpg
# Decrypt key_password.txt.gpg
tmp_key_password=$(gpg --quiet --batch --yes --decrypt --passphrase="$PASSPHRASE" "$GITHUB_WORKSPACE"/encrypted_config/key_password.txt.gpg)

# Inject
echo "storePassword=$tmp_key_password" >"$GITHUB_WORKSPACE"/android/key.properties
echo "keyPassword=$tmp_key_password" >>"$GITHUB_WORKSPACE"/android/key.properties
echo "keyAlias=upload" >>"$GITHUB_WORKSPACE"/android/key.properties
echo "storeFile=./keystore.jks" >>"$GITHUB_WORKSPACE"/android/key.properties
