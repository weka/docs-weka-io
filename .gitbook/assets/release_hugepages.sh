#!/bin/bash

function release_hugepages() {
    path=$1
    page_sizes=(2048kB 1048576kB)

    for page_size in "${page_sizes[@]}"
    do
        nrhp=$(cat $path/hugepages/hugepages-$page_size/nr_hugepages)
        echo "$(basename $path): Releasing $nrhp $page_size hugepages"
        echo 0 > $path/hugepages/hugepages-$page_size/nr_hugepages
        newhp=$(cat $path/hugepages/hugepages-$page_size/nr_hugepages)
        echo "$(basename $path): Current count: $newhp $page_size hugepages"
    done
}

container_states=($(weka local ps --no-header | awk -F' ' '{print $2}'))
for state in "${container_states[@]}"
do
    if [[ "$state" != "Stopped" ]]; then
        echo "All weka containers must be stopped"
        exit 1
    fi
done

rm -rf /mnt/huge/*
rm -rf /mnt/huge1G/*

for node in `ls -1d /sys/devices/system/node/node* `; do
     release_hugepages $node;
done