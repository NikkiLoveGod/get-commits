#!/usr/bin/env bash

# Prints all commits on all given repos and branches in them.
# Tries to answer to "What did I do two days ago?".

set -e

function printHelp() {
  echo ""
  echo 'Usage: ./get-commits.sh [...opts] -p "/paths/to /git/repos /separated/by/spaces"'
  echo 'Example: ./get-commits -a me@domain.com -p "/usr/repos/my-project /usr/repos/my-another-project" --update'
  echo "
  -a | --author   Limit commits to a given author.
  -s | --since    Include commits only after given timeframe. See git log --help for formatting options.
  -u | --update   Fetches latest commits before printing them.
  -h | --help     Print this help.
  -p | --paths    Space separated list of absolute paths into Git repositories.
  "
}

function printCommits() {
  printf "\n## ${1}: \n\n"
  printf "${2}\n"
}

function getCommitsInRepo() {
  local REPOSITORY_PATH=$1
  local AUTHOR=$2

  (cd "${REPOSITORY_PATH}" && git shortlog --all --since="${SINCE}" --pretty=format:"%ai %d %s" --reverse --date=format:"%H" --author="${AUTHOR}")
}

function updateRepo() {
  local REPO_PATH="${1}"

  if [ "${UPDATE_REPOS}" == "true" ] ; then
    (cd "${REPO_PATH}" && git fetch --all > /dev/null)
  fi
}

function printAllCommitsInAllRepos() {
  local COMMITS=""

  for repositoryPath in "${REPOSITORY_PATHS[@]}"; do
    updateRepo "${repositoryPath}"
    COMMITS=$(getCommitsInRepo "${repositoryPath}" "${COMMIT_AUTHOR}")

    printCommits "${repositoryPath}" "${COMMITS}"
  done
}

if [ "$#" -eq 0 ]; then
  printHelp
  exit 0
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -a|--author) COMMIT_AUTHOR="$2"; shift ;;
        -s|--since) SINCE="$2"; shift ;;
        -u|--update) UPDATE_REPOS="true" ;;
        -p|--paths) REPOSITORY_PATHS=(${2}); shift ;;
        -h|--help) printHelp; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# DEFAULTS
COMMIT_AUTHOR=${COMMIT_AUTHOR:-""}
SINCE=${SINCE:-"4.days.ago"}
UPDATE_REPOS=${UPDATE_REPOS:-false}

if [ "${REPOSITORY_PATHS}" == "" ]; then
  echo "Missing repository paths!"
  printHelp
  exit 1
fi

printAllCommitsInAllRepos

exit 0
