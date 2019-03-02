#!/bin/bash
#
# Iterate through tasks in the immediate children of $1 and prompt user to select desired tasks
# Usage: ./tasks.sh dir title

# read task definitions
RAW_TASKS=$(find "$1" -mindepth 2 -maxdepth 2 -type f -name "task.def" -exec printf "{} " \; -exec cat {} \; -exec printf ' \0' \; | sort -z | xargs --null echo -n)
# reparse quoted string as an array
eval "TASKS=($RAW_TASKS)"
# bring dialog
dialog --keep-tite --output-fd 1 --no-tags --item-help --checklist "$2" 20 40 18 "${TASKS[@]}"