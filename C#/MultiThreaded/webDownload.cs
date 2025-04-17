using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Threading;
using System.Net.Http;
using System.Net;

class Program
{
public static string DownloadWebPage(string url)
{
    using (var client = new HttpClient())
    {
        // Force TLS 1.2
        System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

        // Set a user-agent string (some servers require this)
        client.DefaultRequestHeaders.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36");

        try
        {
            HttpResponseMessage response = client.GetAsync(url).Result;
            response.EnsureSuccessStatusCode();
            return response.Content.ReadAsStringAsync().Result;
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
            return null;
        }
    }
}

  static void Main()
  {
    // Setup
    Stopwatch stopwatch = new Stopwatch();
    List<Thread> threads = new List<Thread>();

    // Perform selection sorts and measure time
    stopwatch.Start();
    for (int i=0; i < 16; i++) {
        Thread th = new Thread(() => DownloadWebPage("https://google.com"));
        th.Start();
        threads.Add(th);
    }
    for (int i=0; i<16; i++){
        threads[i].Join();
    }
    stopwatch.Stop();
    TimeSpan duration = stopwatch.Elapsed;
    double durationSecs = duration.TotalMilliseconds/1000;
    string durationStr = durationSecs.ToString("0.000000");

    // Print Results
    Console.WriteLine(durationStr);
  }
}