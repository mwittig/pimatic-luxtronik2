#!/bin/sh
basename "$0"
echo "==============================================="

echo
echo "Installing pimatic"
mkdir pimatic-app
npm install pimatic --prefix pimatic-app --production
