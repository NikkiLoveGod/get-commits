#!/usr/bin/env bash

set -e

# Get all commits accross all repositories and branches, sorted on time

REPOSITORY_PATHS=("/Users/nlg/dev/commitfinder" "/Users/nlg/dev/kouts" "/Users/nlg/dev/simulator" "/Users/nlg/dev/tractr_app");
AUTHOR_UNDER_LENS="sami.kurvinen@gmail.com"
SINCE="4.days.ago"

function getCommitsForAuthor() {
  REPOSITORY_PATH=$1
  AUTHOR=$2


  cd "${REPOSITORY_PATH}" && git log --pretty=format:"%ad <%an> %d %s" --date=format:'%Y-%m-%d %H:%M:%S' --all --since="${SINCE}" --author="${AUTHOR}"
}

function printCommits() {
  printf "\n## ${1}: \n\n"
  printf "${2}\n"
}

for repositoryPath in "${REPOSITORY_PATHS[@]}"; do
  COMMITS=$(getCommitsForAuthor "${repositoryPath}" "${AUTHOR_UNDER_LENS}")
  printCommits "${repositoryPath}" "${COMMITS}"
done
