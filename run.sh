#!/bin/bash

# Defines colors to be used in the script
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

###############################################################################
# C++ Section of the Testing Suite
###############################################################################
echo "===================="
echo -e "Running ${CYAN}C++${NC} Test Suite:"

echo "Compiling Scripts..."
g++ ./C++/SingleThreaded/selSort.cpp -o singleSelSort.o
g++ ./C++/MultiThreaded/selSort.cpp -o multiSelSort.o
g++ ./C++/SingleThreaded/webDownload.cpp -o singleWebDownload.o -lcurl
g++ ./C++/MultiThreaded/webDownload.cpp -o multiWebDownload.o -lcurl

# Selection Sort
echo "--------------------"
echo "Selection Sort:"
singleSelSort=$(./singleSelSort.o)
multiSelSort=$(./multiSelSort.o)
selSortDiff=$(echo "$singleSelSort - $multiSelSort" | bc)
if [ "$(echo "$selSortDiff > 0" | bc)" -eq 1 ]; then
    color=$GREEN
    result="saved"
else 
    color=$RED
    result="lost"
fi
echo "  Execution Time with 1 Thread: ${singleSelSort}s"
echo "  Execution Time with 16 Threads: ${multiSelSort}s"
echo -e "  Time ${result} by multi-threading: ${color}${selSortDiff}${NC}s"
rm "./singleSelSort.o"
rm "./multiSelSort.o"

# Web Download
echo "--------------------"
echo "Web Download:"
singleWebDownload=$(./singleWebDownload.o)
multiWebDownload=$(./multiWebDownload.o)
webDownloadDiff=$(echo "$singleWebDownload - $multiWebDownload" | bc)
if [ "$(echo "$webDownloadDiff > 0" | bc)" -eq 1 ]; then
    color=$GREEN
    result="saved"
else 
    color=$RED
    result="lost"
fi
echo "  Execution Time with 1 Thread: ${singleWebDownload}s"
echo "  Execution Time with 16 Threads: ${multiWebDownload}s"
echo -e "  Time ${result} by multi-threading: ${color}${webDownloadDiff}${NC}s"
rm "./singleWebDownload.o"
rm "./multiWebDownload.o"

# Writing to File






