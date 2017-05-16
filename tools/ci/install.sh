#!/bin/sh

set -e

(
export PREFIX=$HOME/.local SRC_PREFIX=$HOME/build
./install-dependencies.sh all
)


(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan


cpan App::cpanminus

cpanm -h
cpanm --install URI::Escape

