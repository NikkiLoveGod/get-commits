#!/usr/bin/env bash

set -e

# Get all commits accross all repositories and branches, sorted on time

REPOSITORY_PATHS=("/Users/nlg/dev/commitfinder" "/Users/nlg/dev/kouts" "/Users/nlg/dev/simulator" "/Users/nlg/dev/tractr_app");
AUTHOR_UNDER_LENS="sami.kurvinen@gmail.com"
SINCE="4.days.ago"

function getCommitsForAuthor() {
  REPOSITORY_PATH=$1
  AUTHOR=$2

  cd "${REPOSITORY_PATH}" #&& git fetch --all > /dev/null

  git shortlog --all --since="${SINCE}" --pretty=format:"%ci %d %s" --reverse --date=format:"%H"
}

function printCommits() {
  printf "\n## ${1}: \n\n"
  printf "${2}\n"
}

for repositoryPath in "${REPOSITORY_PATHS[@]}"; do
  COMMITS=$(getCommitsForAuthor "${repositoryPath}" "${AUTHOR_UNDER_LENS}")
  printCommits "${repositoryPath}" "${COMMITS}"
done
