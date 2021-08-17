#!/bin/sh -l
# consts
LERNA=lerna.json

echo "Starting automated PR testing"

printf "//npm.pkg.github.com/:_authToken=$env.PRIVATE_REPO_PAT" >> .npmrc

npm install

# Check if a lerna.json exists; if it exists it is a lerna project :)
if [ -f "$LERNA" ]; then
    echo "This project uses lerna..."
    npx lerna link
fi

npm run test --if-present
npm run lint --if-present
