using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.IO;
using System.Threading;

class Program
{
  static Random random = new Random();

  static List<int> generateRandList(int size) {
    List<int> L = new List<int>(size);
    for (int i = 0; i < size; i++) {
      L.Add(random.Next(0, 32767));
    }
  return L;
  }

  static void writeFile(string filename, string contents) {
        using (StreamWriter writer = new StreamWriter(filename))
        {
            writer.WriteLine(contents); // Writes the string to the file
        }
  }
  
  static string readFile(string filename) {
        using (StreamReader reader = new StreamReader(filename))
        {
            string line;
            line = reader.ReadLine();
            return line;
        } 
  }

  static void createReadDelete(string filename, string contents) {
    writeFile(filename, contents);
    readFile(filename);
    File.Delete(filename) ;
  }

  static void Main()
  {
    // Setup and Generate Random number list
    List<int> RandList = generateRandList(16);
    Stopwatch stopwatch = new Stopwatch();
    List<Thread> threads = new List<Thread>();

    // Perform file operations and measure time
    stopwatch.Start();
    for (int i=0; i < RandList.Count; i++) {
      string name = $"randomFile{i}.txt";
      string content = RandList[i].ToString();
      Thread th = new Thread(() => createReadDelete(name, content));
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