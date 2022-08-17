# ltk-pr-action

A shared github action for our PR's : node setup, running unit tests and linting scripts

This Dockerized action is using **Node v16**

## What it does
- Installs the dependencies as defined in your project's `package.json`
- Runs unit tests : `npm run test`
- Runs linting : `npm run lint`

## Setup
1. Your project should have a `package.json` file that contains these scripts:
- `test`
- `lint`

In case they are not present the action will NOT execute them 😄

2. In your action make sure to configure the env variable of `PRIVATE_REPO_PAT`
- This is used for installing private packages


## Example Usage

```yaml
name: Testing and Linting

on: [pull_request]

jobs:
  test_action:
    name: Test the action
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: LoveToKnow/ltk-pr-action@main
        env:
          PRIVATE_REPO_PAT: ${{ secrets.PRIVATE_REPO_PAT }}
```

## Usage with caching

```yaml
name: Testing and Linting 😄

on: [pull_request]

jobs:
  test_action:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Cache node_modules
        uses: actions/cache@v2
        with:
          path: |
            node_modules
            */*/node_modules
          key: ${{ runner.os }}-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-
      - uses: LoveToKnow/ltk-pr-action@main
        env:
          PRIVATE_REPO_PAT: ${{ secrets.PRIVATE_REPO_PAT }}

```