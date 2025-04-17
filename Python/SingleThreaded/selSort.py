import random
import time

def generateRandList(size):
  L = []
  for i in range(0, size):
    L.append(random.randint(0, 32767))
  return L

def selectionSort(A):
  min = 0
  for i in range(0, len(A)):
    min = i
    for j in range(i+1, len(A)):
      if (A[j] < A[min]):
        min = j
    swp = A[i]
    A[i] = A[min]
    A[min] = swp
  return A

if __name__ == "__main__":
  # Setup and Generate Random number lists
  RandList = []
  for i in range(0, 16):
    RandList.append(generateRandList(10000))

  # Perform selection sorts and measure time
  start = time.perf_counter()
  for i in range(0, 16):
    selectionSort(RandList[i])
  stop = time.perf_counter()
  duration = stop - start

  # Print Results
  print(f'{duration:5f}')