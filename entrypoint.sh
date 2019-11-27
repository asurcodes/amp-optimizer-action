#!/bin/bash

set -e
# set -ex

function print_error() {
    echo -e "\e[31mERROR: ${1}\e[m"
}

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

function skip() {
    print_info "No changes detected, skipping deployment"
    exit 0
}

for file in $(find ${INPUT_ROOT} -name "*.html"); do
    [ -f "$file" ] || break
    print_info "Optimizing $file" 
    $GOPATH/bin/transform $file > /tmp/optimized.txt
    [ -s /tmp/optimized.txt ] && cat /tmp/optimized.txt > $file || print_error "Not a valid AMP page. Omitting..."
done