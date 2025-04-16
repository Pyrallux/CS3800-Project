#include <chrono>
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

std::vector<int> selectionSort(std::vector<int> A) {
  int min = 0;
  int swp;
  for (int i = 0; i < A.size() - 1; i++) {
    min = i;
    for (int j = i + 1; j < A.size(); j++) {
      if (A[j] < A[min]) {
        min = j;
      }
    }
    swp = A[i];
    A[i] = A[min];
    A[min] = swp;
  }
  return A;
}

int main() {
  // Setup and Generate Random number lists
  std::srand(std::time(0));
  std::vector<std::vector<int>> RandList(16);
  for (int i = 0; i < RandList.size(); i++) {
    RandList[i] = generateRandList(10000);
  }
  std::vector<std::thread> threads;

  // Perform selection sorts and measure time
  auto start = high_resolution_clock::now();
  for (int i = 0; i < RandList.size(); i++) {
    threads.push_back(std::thread(selectionSort, RandList[i]));
  }
  for (auto &th : threads)
    th.join();
  auto stop = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(stop - start);

  // Print Results
  std::cout << static_cast<float>(duration.count()) / 1000000 << std::endl;

  return 0;
}
