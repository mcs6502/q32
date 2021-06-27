#! /bin/bash

# the sleep is a workaround for "rlwrap: error: My terminal reports width=0 (is it emacs?)"
sleep 1

# location of the data volume
DATA_DIR=/data

# change current dir to mounted data volume for local loads in q
cd $DATA_DIR

# tell rlwrap to place history files away from home dir
: "${RLWRAP_HOME:=$DATA_DIR}"
export RLWRAP_HOME

# hand over control to the q interpreter via rlwrap
exec /usr/bin/rlwrap /root/q/l32/q "$@"
