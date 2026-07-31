#!/usr/bin/env fish

# Go to the directory this script is in
cd (dirname (status --current-filename))

# Run packwiz

packwiz curseforge export

set bluewool_version (git describe --tags --abbrev=0 2>/dev/null)

set bluewool_version (string replace -r '^v' '' -- $bluewool_version)

set file_name "Bluewool 1.21.1-$bluewool_version.zip"

mv Bluewool.zip $file_name

ln -sf $file_name Bluewool.zip

echo "Renamed file to $file_name"
echo "Updated Bluewool.zip symlink to point to $file_name"