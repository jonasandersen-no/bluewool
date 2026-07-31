#!/usr/bin/env fish

# Go to the directory this script is in
cd (dirname (status --current-filename))/../bluewool-testing-server

docker compose down

docker compose up