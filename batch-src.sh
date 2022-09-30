#!/bin/bash

convertFile() {
    INPUT_PATH=$1

    # replace first occurrence of root path with converted root path
    # creates a new directory to house converted files with same structure as original
    OUTPUT_PATH="${INPUT_PATH/$ROOT_PATH/$ROOT_PATH_CONVERTED}"
    mkdir -p "$(dirname "$OUTPUT_PATH")"

    echo "Processing $INPUT_PATH ---> $OUTPUT_PATH"

    sox $INPUT_PATH -b 16 -r 48k $OUTPUT_PATH
}

processFiles() {
    PATH_TO_FILES="$1/*"
    for f in $PATH_TO_FILES
    do
        if [ -d "${f}" ]; then
            processFiles "$f"
        elif [ "${f: -4}" == ".wav" ]; then
            convertFile $f
        else
            echo " - Skipping $f"
        fi
    done
}

ROOT_PATH=$1
ROOT_PATH_CONVERTED=$2

if [ -z "$ROOT_PATH" ]; then
    echo "please provide directory to convert"
elif [ ! -d "${ROOT_PATH}" ]; then
    echo "invalid or empty directory $ROOT_PATH"
elif [ -z "$ROOT_PATH_CONVERTED" ]; then
    echo "please provide output directory"
else
    echo "=========== PROCESSING ==========="
    echo ""
    processFiles $ROOT_PATH
    echo ""
    echo "=========== COMPLETE ==========="
fi