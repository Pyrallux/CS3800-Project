#include <chrono>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <thread>
#include <vector>

using namespace std::chrono;

std::vector<int> generateRandList(int size) {
  std::vector L(size, 0);
  for (int i = 0; i < L.size(); i++) {
    L[i] = std::rand();
  }
  return L;
}

void writeFile(const std::string &filename, int contents) {
  std::ofstream outputFile(filename);
  outputFile << contents << std::endl;
  outputFile.close();
}

int readFile(const std::string &filename) {
  std::ifstream inputFile(filename);
  std::string text;
  std::getline(inputFile, text);
  inputFile.close(); // Close the file when done
  return std::stoi(text);
}

void createReadDelete(const std::string &filename, int contents) {
  writeFile(filename, contents);
  readFile(filename);
  std::remove(filename.c_str()); // Deletes File
}

int main() {
  // Setup and Generate Random number lists
  std::srand(std::time(0));
  std::vector<int> RandList = generateRandList(16);
  std::vector<std::thread> threads;

  // Create, Read, and Delete Files + Time
  auto start = high_resolution_clock::now();
  for (int i = 0; i < RandList.size(); i++) {
    std::string name = "randomFile" + std::to_string(i) + ".txt";
    threads.push_back(std::thread(createReadDelete, name, RandList[i]));
  }
  for (auto &th : threads)
    th.join();
  auto stop = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(stop - start);

  // Print Results
  std::cout << static_cast<float>(duration.count()) / 1000000 << std::endl;

  return 0;
}
