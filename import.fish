#!/usr/bin/env fish

cd (dirname (status --current-filename))

packwiz curseforge import import.zip

echo "Imported zip file"