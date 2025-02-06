#!/usr/bin/env sh
set -e

usage() {
    echo "Usage: $0 <backup|restore> <archive-filename> [<source-path>...]" 1>&2
    exit 1
}

[ $# -ge 2 ] || usage
CIPHER=aes256
COMMAND=$1
ARCHIVE=$2
shift 2

case $COMMAND in
backup)
    tar -czf - -C "$HOME" "$@" | openssl enc -$CIPHER -e -out "$ARCHIVE"
    ;;
restore)
    openssl enc -$CIPHER -d -in "$ARCHIVE" | tar -xzk -C "$HOME"
    ;;
*)
    usage
    ;;
esac
