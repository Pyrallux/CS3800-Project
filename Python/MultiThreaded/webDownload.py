import requests
import time
import threading

def getRequest(url):
    requests.get(url)

if __name__ == "__main__":
  # Setup
  threads = []

  # Download webpages and record time
  start = time.perf_counter()
  for i in range(0, 16):
    th = threading.Thread(target=getRequest, args=("https://google.com",))
    th.start()
    threads.append(th)
  for th in threads:
     th.join()
  stop = time.perf_counter()
  duration = stop - start

  # Print Results
  print(f'{duration:5f}')