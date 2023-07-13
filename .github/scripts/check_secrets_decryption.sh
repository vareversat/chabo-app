#!/bin/bash

if [ -s "$GITHUB_WORKSPACE"/android/app/keystore.jks ]; then
  echo "keystore.jks ✅"
else
  echo "keystore.jks is empty ❌"
  exit 1
fi

if [ -s "$GITHUB_WORKSPACE"/android/fastlane/fastlane-key.json ]; then
  echo "fastlane-key.json ✅"
else
  echo "fastlane-key.json is empty ❌"
  exit 1
fi

exit 0
