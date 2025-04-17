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
g++ ./C++/SingleThreaded/crdFiles.cpp -o singleCRD.o 
g++ ./C++/MultiThreaded/crdFiles.cpp -o multiCRD.o 

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

# Create, Read, and Delete Files
echo "--------------------"
echo "Create, Read, and Delete Files:"
singleCRD=$(./singleCRD.o)
multiCRD=$(./multiCRD.o)
CRDDiff=$(echo "$singleCRD - $multiCRD" | bc)
if [ "$(echo "$CRDDiff > 0" | bc)" -eq 1 ]; then
    color=$GREEN
    result="saved"
else 
    color=$RED
    result="lost"
fi
echo "  Execution Time with 1 Thread: ${singleCRD}s"
echo "  Execution Time with 16 Threads: ${multiCRD}s"
echo -e "  Time ${result} by multi-threading: ${color}${CRDDiff}${NC}s"
rm "./singleCRD.o"
rm "./multiCRD.o"


###############################################################################
# Python Section of the Testing Suite
###############################################################################
echo "===================="
echo -e "Running ${CYAN}Python ${NC} Test Suite:"

# Selection Sort
echo "--------------------"
echo "Selection Sort:"
singleSelSort=$(python3 ./Python/SingleThreaded/selSort.py)
multiSelSort=$(python3 ./Python/MultiThreaded/selSort.py)
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

# Web Download
echo "--------------------"
echo "Web Download:"
singleWebDownload=$(python3 ./Python/SingleThreaded/webDownload.py)
multiWebDownload=$(python3 ./Python/MultiThreaded/webDownload.py)
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

# CRD Files
echo "--------------------"
echo "Create, Read, and Delete Files:"
singleCrdFiles=$(python3 ./Python/SingleThreaded/crdFiles.py)
multiCrdFiles=$(python3 ./Python/MultiThreaded/crdFiles.py)
crdFilesDiff=$(echo "$singleCrdFiles - $multiCrdFiles" | bc)
if [ "$(echo "$crdFilesDiff > 0" | bc)" -eq 1 ]; then
    color=$GREEN
    result="saved"
else 
    color=$RED
    result="lost"
fi
echo "  Execution Time with 1 Thread: ${singleCrdFiles}s"
echo "  Execution Time with 16 Threads: ${multiCrdFiles}s"
echo -e "  Time ${result} by multi-threading: ${color}${crdFilesDiff}${NC}s"