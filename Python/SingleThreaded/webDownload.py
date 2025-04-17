import requests
import time

def getRequest(url):
    requests.get(url)

if __name__ == "__main__":
  # Download webpages and record time
  start = time.perf_counter()
  for i in range(0, 16):
    getRequest("https://google.com")
  stop = time.perf_counter()
  duration = stop - start

  # Print Results
  print(f'{duration:5f}')