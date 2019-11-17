#!/bin/bash
#
# Add an alias in .bash_aliases
# Usage: add-alias.sh name command


ALIAS_FILE=$HOME/.bash_aliases
sed -i "/alias $1=/d" $ALIAS_FILE
echo "alias $1=\"$2\"" >> $ALIAS_FILE
source $ALIAS_FILE
