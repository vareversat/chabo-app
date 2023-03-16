#!/bin/bash

BUILD_NUMBER=$(git rev-list --all --count)
CHANGELOG_PATH_FR="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/fr-FR/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_PATH_EN_US="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/en-US/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_PATH_EN_GB="$GITHUB_WORKSPACE"/android/fastlane/metadata/android/en-GB/changelogs/"$BUILD_NUMBER".txt
CHANGELOG_FR=$(sed '/\*\*\*/q' "$GITHUB_WORKSPACE"/CHANGELOG_fr.md | sed 's/\*//g' | sed 's/#//g' | sed '$d')
CHANGELOG_EN=$(sed '/\*\*\*/q' "$GITHUB_WORKSPACE"/CHANGELOG_en.md | sed 's/\*//g' | sed 's/#//g' | sed '$d')

# Add path to the Github envs
echo "CHANGELOG_PATH_FR=$CHANGELOG_PATH_FR" >> $GITHUB_ENV
echo "CHANGELOG_PATH_EN_US=$CHANGELOG_PATH_EN_US" >> $GITHUB_ENV
echo "CHANGELOG_PATH_EN_GB=$CHANGELOG_PATH_EN_GB" >> $GITHUB_ENV
# Write changelog into the file
echo "$CHANGELOG_FR" > "$CHANGELOG_PATH_FR"
echo "$CHANGELOG_EN" > "$CHANGELOG_PATH_EN_US"
echo "$CHANGELOG_EN" > "$CHANGELOG_PATH_EN_GB"

if [ -s "$CHANGELOG_PATH" ]; then
  echo "Changelog generated ✅"
  echo "New changelog (path : $CHANGELOG_PATH)"
  cat "$CHANGELOG_PATH"
  exit 0
else
  echo "Changelog is missing ❌"
  exit 1
fi
