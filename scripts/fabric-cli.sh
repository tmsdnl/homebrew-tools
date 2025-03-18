#!/bin/bash

# CONFIGURATION
FABRIC_REPO="danielmiessler/fabric"
GITHUB_REPO="tmsdnl/homebrew-tools"
FORMULA_FILE="../Formula/fabric-cli.rb"
GIT_BRANCH="main"

# Define the assets to download
ASSETS=("fabric-darwin-amd64" "fabric-darwin-arm64")

# Fetch the latest release tag from GitHub API
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$FABRIC_REPO/releases/latest" | jq -r '.tag_name')

# Read the current version from the formula file
CURRENT_VERSION=$(grep 'version "' "$FORMULA_FILE" | sed -E 's/version "(.*)"/\1/' | tr -d '[:space:]')

if [[ "$LATEST_RELEASE" == "null" || -z "$LATEST_RELEASE" ]]; then
    echo "Error: Unable to fetch latest release for $FABRIC_REPO"
    exit 1
fi

echo "Latest Release: $LATEST_RELEASE"
echo "Current Version: $CURRENT_VERSION"

# Check if we need to update
if [[ "$LATEST_RELEASE" == "$CURRENT_VERSION" ]]; then
    echo "The formula is already up-to-date."
    exit 0
fi

echo "Updating formula..."

# Initialize empty hash variables
SHA256_ARM64=""
SHA256_AMD64=""

# Download, calculate SHA256, and update formula
for ASSET in "${ASSETS[@]}"; do
    # Fetch the latest release download URL for the asset
    DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/$FABRIC_REPO/releases/latest" | jq -r ".assets[] | select(.name == \"$ASSET\") | .browser_download_url")

    if [[ -z "$DOWNLOAD_URL" ]]; then
        echo "Error: No matching download URL found for $ASSET"
        exit 1
    fi

    echo "Downloading $ASSET..."
    TEMP_FILE=$(mktemp)
    curl -L -o "$TEMP_FILE" "$DOWNLOAD_URL"

    # Compute SHA256 checksum
    HASH=$(sha256sum "$TEMP_FILE" | awk '{print $1}')

    # Store hashes in separate variables
    if [[ "$ASSET" == "fabric-darwin-arm64" ]]; then
        SHA256_ARM64="$HASH"
    elif [[ "$ASSET" == "fabric-darwin-amd64" ]]; then
        SHA256_AMD64="$HASH"
    fi

    echo "SHA256 ($ASSET): $HASH"

    # Cleanup temp file
    rm "$TEMP_FILE"
done

# Detect OS to determine correct sed syntax
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED_INPLACE=('sed' '-i' '')
else
    SED_INPLACE=('sed' '-i')
fi

# Update the formula file
"${SED_INPLACE[@]}" "s/version \".*\"/version \"$LATEST_RELEASE\"/" "$FORMULA_FILE"
"${SED_INPLACE[@]}" "/fabric-darwin-arm64/{n;s/sha256 \".*\"/sha256 \"${SHA256_ARM64["fabric-darwin-arm64"]}\"/;}" "$FORMULA_FILE"
"${SED_INPLACE[@]}" "/fabric-darwin-amd64/{n;s/sha256 \".*\"/sha256 \"${SHA256_AMD64["fabric-darwin-amd64"]}\"/;}" "$FORMULA_FILE"

echo "Formula updated!"

# Commit & Push changes
if [[ "$GITHUB_ACTIONS" == "true" ]]; then
    git config --global user.email "github-actions@github.com"
    git config --global user.name "GitHub Actions Bot"
fi

git add "$FORMULA_FILE"
git commit -m "chore(fabric-cli): $LATEST_RELEASE"
git push "https://$GH_TOKEN@github.com/$GITHUB_REPO.git" "$GIT_BRANCH"

echo "Changes pushed to origin/$GIT_BRANCH!"