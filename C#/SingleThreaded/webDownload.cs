using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Net;

class Program
{
  static WebClient client = new WebClient();

  static string getRequest(string url) {
        try
        {
            string html = client.DownloadString(url);
            return html;
        }
        catch (WebException e)
        {
            Console.WriteLine($"Error: {e.Message}");
            return e.Message;
        }
  }

  static void Main()
  {
    // Setup
    Stopwatch stopwatch = new Stopwatch();

    // Perform selection sorts and measure time
    stopwatch.Start();
    for (int i=0; i < 16; i++) {
      getRequest("https://esports.mst.edu");
    }
    stopwatch.Stop();
    TimeSpan duration = stopwatch.Elapsed;
    double durationSecs = duration.TotalMilliseconds/1000;
    string durationStr = durationSecs.ToString("0.000000");

    // Print Results
    Console.WriteLine(durationStr);
  }
}