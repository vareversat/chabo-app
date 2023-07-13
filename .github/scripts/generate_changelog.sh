#!/bin/bash

BUILD_NUMBER=$(git rev-list --all --count)
CHANGELOG_PATH_FR="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/fr-FR/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_PATH_ES="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/es-ES/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_PATH_EN_US="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/en-US/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_PATH_EN_GB="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/en-GB/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_FR=$(sed '/\*\*\*/q' "$GITHUB_WORKSPACE"/changelogs/CHANGELOG_fr.md | sed 's/\*//g' | sed 's/#//g' | sed '$d')
CHANGELOG_ES=$(sed '/\*\*\*/q' "$GITHUB_WORKSPACE"/changelogs/CHANGELOG_es.md | sed 's/\*//g' | sed 's/#//g' | sed '$d')
CHANGELOG_EN=$(sed '/\*\*\*/q' "$GITHUB_WORKSPACE"/changelogs/CHANGELOG_en.md | sed 's/\*//g' | sed 's/#//g' | sed '$d')

# Add path to the Github envs
echo "CHANGELOG_PATH_FR=$CHANGELOG_PATH_FR" >> $GITHUB_ENV
echo "CHANGELOG_PATH_ES=$CHANGELOG_PATH_ES" >> $GITHUB_ENV
echo "CHANGELOG_PATH_EN_US=$CHANGELOG_PATH_EN_US" >> $GITHUB_ENV
echo "CHANGELOG_PATH_EN_GB=$CHANGELOG_PATH_EN_GB" >> $GITHUB_ENV
# Write changelog into the file
echo "$CHANGELOG_FR" > "$CHANGELOG_PATH_FR"
echo "$CHANGELOG_ES" > "$CHANGELOG_PATH_ES"
echo "$CHANGELOG_EN" > "$CHANGELOG_PATH_EN_US"
echo "$CHANGELOG_EN" > "$CHANGELOG_PATH_EN_GB"

if [ -s "$CHANGELOG_PATH_FR" ]; then
  echo "Changelog generated ✅"
  echo "New FR changelog (path : $CHANGELOG_PATH_FR)"
else
  echo "FR Changelog is missing ❌"
  exit 1
fi

if [ -s "$CHANGELOG_PATH_ES" ]; then
  echo "Changelog generated ✅"
  echo "New ES changelog (path : $CHANGELOG_PATH_ES)"
else
  echo "ES Changelog is missing ❌"
  exit 1
fi

if [ -s "$CHANGELOG_PATH_EN_US" ]; then
  echo "Changelog generated ✅"
  echo "New EN_US changelog (path : $CHANGELOG_PATH_EN_US)"
else
  echo "EN_US Changelog is missing ❌"
  exit 1
fi

if [ -s "$CHANGELOG_PATH_EN_GB" ]; then
  echo "Changelog generated ✅"
  echo "New EN_GB changelog (path : $CHANGELOG_PATH_EN_GB)"
else
  echo "EN_GB Changelog is missing ❌"
  exit 1
fi

exit 0