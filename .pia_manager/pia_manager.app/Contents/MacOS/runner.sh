#!/bin/bash

DIR=$(dirname "$0")
export DYLD_LIBRARY_PATH="$DIR/osxruby"
exec "$DIR/osxruby/ruby" -I"$DIR/osxruby" "$DIR/run.rb" "$@"
