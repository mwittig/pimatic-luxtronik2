#!/bin/bash
basename "$0"
echo "==============================================="

mkdir -p pimatic-app/node_modules/pimatic-luxtronik2

cp -R * pimatic-app/node_modules/pimatic-luxtronik2/

echo "Installing pimatic"

npm install pimatic --prefix pimatic-app --production

cp .ci/config.json pimatic-app/