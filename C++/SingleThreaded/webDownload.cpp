#include <chrono>
#include <curl/curl.h>
#include <iostream>

using namespace std::chrono;

// Dummy write callback that discards data
size_t DiscardCallback(void *contents, size_t size, size_t nmemb, void *userp) {
  return size * nmemb;
}

// Performs GET Request to a given website
void getRequest(const std::string &url) {
  CURL *curl;
  CURLcode res;

  curl_global_init(CURL_GLOBAL_DEFAULT);
  curl = curl_easy_init();

  if (curl) {
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, DiscardCallback);

    res = curl_easy_perform(curl);

    if (res != CURLE_OK) {
      std::cerr << "curl_easy_perform() failed: " << curl_easy_strerror(res)
                << std::endl;
    }

    curl_easy_cleanup(curl);
  }
  curl_global_cleanup();
}

int main() {

  // Perform web requests and measure time
  auto start = high_resolution_clock::now();
  for (int i = 0; i < 16; i++) {
    getRequest("https://esports.mst.edu");
  }
  auto stop = high_resolution_clock::now();
  auto duration = duration_cast<microseconds>(stop - start);

  // Print Results
  std::cout << static_cast<float>(duration.count()) / 1000000 << std::endl;

  return 0;
}
