#!/bin/bash
# Start a new tmux session or reconnect to an existing one in VScode

REPO_PATH=$(git rev-parse --show-toplevel)
REPO=$(basename $REPO_PATH)
SESSION_NAME="${REPO:-tmp_`date +'%Y%m%d'`}"

echo Attaching to tmux session: $SESSION_NAME
tmux new -A -s $SESSION_NAME
