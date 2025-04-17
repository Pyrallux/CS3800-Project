import random
import time
import os
import threading

def generateRandList(size):
  L = []
  for i in range(0, size):
    L.append(random.randint(0, 32767))
  return L

def writeFile(filename, contents):
  with open(filename, 'w') as file:
    file.write(contents)

def readFile(filename):
  with open(filename, 'r') as file:
    return file.read()
  
def createReadDelete(filename, contents):
  writeFile(filename, contents)
  readFile(filename)
  os.remove(filename)

if __name__ == "__main__":
  # Setup and Generate Random number lists
  RandList = generateRandList(16)
  threads = []

  # Perform selection sorts and measure time
  start = time.perf_counter()
  for i in range(0, 16):
    name = f"randomFile{i}.txt"
    th = threading.Thread(target=createReadDelete, args=(name, str(RandList[i])))
    th.start()
    threads.append(th)
  for th in threads:
    th.join()
  stop = time.perf_counter()
  duration = stop - start

  # Print Results
  print(f'{duration:5f}')