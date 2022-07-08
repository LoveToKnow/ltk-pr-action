#!/bin/sh -l

# Exit immediately if something goes wrong
set -e

# consts
LERNA=lerna.json

echo "Starting automated PR testing"

# Collect all the packages in the monorepo ;)
if [ -f "$LERNA" ]; then
    find . -type d -name node_modules -prune -o -name "package.json" -exec jq -s '.[0] as $a | .[1] as $b | $a * $b | .dependencies = $a.dependencies + $b.dependencies | .devDependencies = $a.devDependencies + $b.devDependencies' {} +  > p.json
    rm -f package.json
    mv p.json package.json
fi

npm install --userconfig /.npmrc.ci

# Check if a lerna.json exists; if it exists it is a lerna project :)
if [ -f "$LERNA" ]; then
    echo "This project uses lerna..."
    npx lerna link --force-local
fi

npm run test --if-present
npm run lint --if-present
