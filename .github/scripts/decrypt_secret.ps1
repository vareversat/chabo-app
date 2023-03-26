Set-Item -Path Env:PASSPHRASE -Value "MY_SECRET"
# Decrypt keystore.jks.gpg
& gpg --batch --yes --decrypt --pinentry-mode loopback --passphrase="$env:PASSPHRASE" --output "android/app/keystore.jks" "encrypted_config/keystore.jks.gpg"
# Decrypt fastlane-key.json.gpg
& gpg --batch --yes --decrypt --pinentry-mode loopback --passphrase="$env:PASSPHRASE" --output "android/fastlane/fastlane-key.json" "encrypted_config/fastlane-key.json.gpg"
# Decrypt key_password.txt.gpg
$tmp_key_password = (& gpg --quiet --batch --yes --decrypt --passphrase="$env:PASSPHRASE" "encrypted_config/key_password.txt.gpg") -join "`n"

# Inject
echo "storePassword=$tmp_key_password" > "android/key.properties"
echo "keyPassword=$tmp_key_password" >> "android/key.properties"
echo "keyAlias=upload" >> "android/key.properties"
echo "storeFile=./keystore.jks" >> "android/key.properties"
