#!/bin/bash
# Update all git repos in a directory $1 (absoulte path)
set -euo pipefail
BASE_DIR=$1

echo -e "\n \x1B[32m Updating all repos in $BASE_DIR \x1B[0m"

for repo in $(find $BASE_DIR -type d -exec test -e '{}/.git' ';' -print -prune); do
  echo -e "\n \x1B[36m Updating repo $repo \x1B[0m"
  cd $repo
  git pull --all
  git status
  git branch
done
