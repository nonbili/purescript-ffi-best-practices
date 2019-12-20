#!/bin/bash

practices=("ArrowFunction" "Json" "NoTypeClass" "Promise")

for p in ${practices[@]}; do
    # From https://unix.stackexchange.com/a/61146
    sed -n '/^```/,/^```/ p' \
        < src/Practice/$p/README.md \
        | sed 's/^```.*//' > src/Practice/$p/Main.purs
done
