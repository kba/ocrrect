#!/bin/bash

set -ex

usage() {
    echo "$0 <ocr-gt-dir>"
    if [[ ! -z "$@" ]];then
        echo "$@"
    fi
}

# while [[ "$1" =~ ^- ]];do
#     case "$1" in
#         --
# done

ocrgtdir="$1"
if [[ -z "$ocrgtdir" ]];then
    usage
    exit 1
fi
if [[ ! -d "$ocrgtdir" ]];then
    usage "!! No such dir: '$ocrgtdir' !!"
    exit 1
fi

mktempdir() {
    tempbasedir=$(mktemp --tmpdir -d "ocrgt.XXXXXXXX")
    # shellcheck disable=SC2001
    tempsubdir=$(echo "$ocrgtdir"|sed 's/[^a-zA-Z0-9]\+/_/g')
    tempdir="$tempbasedir/$tempsubdir"
    mkdir -p "$tempdir"
}

mktempdir
cd "$ocrgtdir"
for i in line-*.txt;do
    lineId=$(echo "$i"|grep -o '[0-9]\+')
    linedir="$tempdir/line/$lineId"
    mkdir -p "$linedir"
    cp "$i" "$linedir/transcription.txt"
    cp "${i/.txt/.png}" "$linedir/image.png"
    cp "comment-$i" "$linedir/comment.txt"
done
cd "$tempbasedir"
zip -r "$tempsubdir.zip" "$tempsubdir"
echo "$tempbasedir"
# rm -rf "$tempdir"
