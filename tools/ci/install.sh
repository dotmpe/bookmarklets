#!/bin/sh

set -e

(
export PREFIX=$HOME/.local SRC_PREFIX=$HOME/build
./install-dependencies.sh all
)


cpanm -h
cpanm --install URI::Escape

