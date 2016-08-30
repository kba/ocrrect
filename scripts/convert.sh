#!/bin/bash

set -e

if [[ -z "$1" ]];then
    echo "Usage: $(basename "$0") <rootdir>"
fi

cd "$1"

find . -mindepth 2 -maxdepth 2 -type d | while read pagedir;do
    ppn=${pagedir:2:9}
    page=${pagedir:12:4}
    echo "$pagedir"
    (
        cd "$pagedir"
        mkdir -p hocr
        mv -t hocr "${ppn}_${page}.hocr"
        mkdir -p max
        mv -t max "${ppn}_${page}.jpg"
        mkdir -p line
        for line in $(find .|sed 's/.*-//'|sed 's/\..*$//'|grep -v 'page'|sort|uniq);do
            echo "  $line"
            linedir="line/$line"
            mkdir -p "$linedir"
            if [[ -e "comment-line-$line.txt" ]];then
                mv "comment-line-$line.txt" "$linedir/comment.txt"
            fi
            if [[ -e "line-$line.txt" ]];then
                mv "line-$line.txt" "$linedir/transcription.txt"
            fi
            if [[ -e "line-$line.png" ]];then
                mv "line-$line.png" "$linedir/extract.png"
            fi
            if [[ -e "ocr-line-$line.txt" ]];then
                mv "ocr-line-$line.txt" "$linedir/ocr.txt"
            fi
        done
    )
done
