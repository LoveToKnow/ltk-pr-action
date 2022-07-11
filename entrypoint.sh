#!/bin/sh -l

# Exit immediately if something goes wrong
set -e

# consts
LERNA=lerna.json

echo "Starting automated PR testing"

npm install --userconfig /.npmrc.ci

# Check if a lerna.json exists; if it exists it is a lerna project :)
if [ -f "$LERNA" ]; then
    echo "This project uses lerna..."
    npx lerna bootstrap
    npx lerna link --force-local
fi

npm run test --if-present
npm run lint --if-present
