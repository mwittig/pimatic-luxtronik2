#!/bin/sh
basename "$0"
echo "==============================================="

echo
echo "Installing pimatic"
cd ..
mkdir pimatic-app
npm install pimatic --prefix pimatic-app --production
