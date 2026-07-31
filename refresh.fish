#!/usr/bin/env fish

# Go to the directory this script is in
cd (dirname (status --current-filename))

# Run packwiz

packwiz curseforge import import.zip

packwiz refresh

packwiz curseforge export