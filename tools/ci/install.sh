#!/bin/sh

set -e

(
export PREFIX=$HOME/.local SRC_PREFIX=$HOME/build
./install-dependencies.sh all
)

cpan App::cpanminus

cpanm -h
cpanm --install URI::Escape

