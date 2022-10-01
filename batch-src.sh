#!/bin/bash

convertFile() {
    INPUT_PATH=$1

    # replace first occurrence of root path with converted root path
    # creates a new directory to house converted files with same structure as original
    OUTPUT_PATH="${INPUT_PATH/$ROOT_PATH/$ROOT_PATH_OUTPUT}"
    mkdir -p "$(dirname "$OUTPUT_PATH")"

    echo "Processing $INPUT_PATH ---> $OUTPUT_PATH"

    sox "$INPUT_PATH" -r $SAMPLE_RATE -b $BIT_DEPTH "$OUTPUT_PATH" norm $NORMALIZE_TO
}

processFiles() {
    PATH_TO_FILES="$1/*"

    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")

    for f in $PATH_TO_FILES
    do
        if [ -d "${f}" ]; then
            processFiles $f
        elif [ "${f: -4}" == ".wav" ]; then
            convertFile "$f"
        else
            echo " - Skipping $f"
        fi
    done

    IFS=$SAVEIFS
}

ROOT_PATH=$1
ROOT_PATH_OUTPUT=$2
SAMPLE_RATE=$3
BIT_DEPTH=$4
NORMALIZE_TO=$5

# strip trailing / characters
if [ "${ROOT_PATH: -1}" == "/" ]; then
    ROOT_PATH=${ROOT_PATH%?}
fi
if [ "${ROOT_PATH_OUTPUT: -1}" == "/" ]; then
    ROOT_PATH_OUTPUT=${ROOT_PATH_OUTPUT%?}
fi
# set defaults if not specified
if [ -z "$SAMPLE_RATE" ]; then
    SAMPLE_RATE="48k"
fi
if [ -z "$BIT_DEPTH" ]; then
    BIT_DEPTH="16"
fi
if [ -z "$NORMALIZE_TO" ]; then
    NORMALIZE_TO="-3"
fi

if [ -z "$ROOT_PATH" ]; then
    echo "please provide directory to convert"
elif [ ! -d "${ROOT_PATH}" ]; then
    echo "invalid or empty directory $ROOT_PATH"
elif [ -z "$ROOT_PATH_OUTPUT" ]; then
    echo "please provide output directory"
# prevent infinite loop
elif [[ $ROOT_PATH_OUTPUT == "$ROOT_PATH/"* ]]; then
    echo "please provide output directory outside of source directory"
else
    echo "=========== PROCESSING ==========="
    echo ""
    processFiles "$ROOT_PATH"
    echo ""
    echo "============ COMPLETE ============"
fi