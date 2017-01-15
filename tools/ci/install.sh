#!/bin/sh

set -e

PREFIX=$DEP_PREFIX ./install-dependencies.sh all
cpanm -h
cpanm --install URI::Escape

