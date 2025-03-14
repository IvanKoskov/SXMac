#!/bin/bash

# Define the path to the SXMac app
app_path="/Applications/SXMac.app"

# Function to remove all Apple restrictions by disabling Gatekeeper
disable_gatekeeper() {
  echo "Disabling Gatekeeper..."

  # Check macOS version
  macos_version=$(sw_vers -productVersion)
  major_version=$(echo $macos_version | cut -d '.' -f 1)
  minor_version=$(echo $macos_version | cut -d '.' -f 2)

  if [[ $major_version -ge 11 ]]; then
    # For macOS 11 and newer
    sudo spctl --global-disable
    echo "Gatekeeper disabled for macOS 11 and newer."
  elif [[ $major_version -ge 10 && $minor_version -ge 12 && $minor_version -le 15 ]]; then
    # For macOS 10.12 to 10.15.7
    sudo spctl --master-disable
    echo "Gatekeeper disabled for macOS 10.12 to 10.15.7."
  else
    echo "Unsupported macOS version: $macos_version"
    exit 1
  fi
}

# Function to remove extended attributes from the SXMac app
remove_extended_attributes() {
  echo "Removing extended attributes for $app_path..."
  sudo xattr -r -c "$app_path"
  echo "Extended attributes removed for $app_path."
}

# Main execution
if [ ! -d "$app_path" ]; then
  echo "The SXMac app does not exist at the specified location: $app_path"
  exit 1
fi

# Disable Gatekeeper and remove extended attributes
disable_gatekeeper
remove_extended_attributes

echo "All tasks completed for SXMac."
