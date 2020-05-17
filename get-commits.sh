#!/usr/bin/env bash

set -e

# Get all commits across all repositories and branches, sorted on time

REPOSITORY_PATHS=(${1});
COMMIT_AUTHOR=${2}
SINCE=${3:-"4.days.ago"}
UPDATE_REPO=${4:-false}

function printCommits() {
  printf "\n## ${1}: \n\n"
  printf "${2}\n"
}

function getCommitsForAuthor() {
  REPOSITORY_PATH=$1
  AUTHOR=$2

  cd "${REPOSITORY_PATH}" && git shortlog --all --since="${SINCE}" --pretty=format:"%ai %d %s" --reverse --date=format:"%H" --author="${AUTHOR}"
}

function updateRepo() {
  cd ${1}

  if [ "${UPDATE_REPO}" == "true" ] ; then
    git fetch --all > /dev/null
  fi

  cd ..
}

for repositoryPath in "${REPOSITORY_PATHS[@]}"; do
  updateRepo "${repositoryPath}"
  COMMITS=$(getCommitsForAuthor "${repositoryPath}" "${COMMIT_AUTHOR}")
  printCommits "${repositoryPath}" "${COMMITS}"
done
