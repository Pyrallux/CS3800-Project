using System;
using System.Threading;
using System.Diagnostics;
using System.Collections.Generic;

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

  static List<int> selectionSort(List<int> A) {
  int min = 0;
  int swp;
  for (int i = 0; i < A.Count - 1; i++) {
    min = i;
    for (int j = i + 1; j < A.Count; j++) {
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

  static void Main()
  {
    // Setup and Generate Random number lists
    List<List<int>> RandList = new List<List<int>>(16);
    for (int i = 0; i<16; i++) {
      RandList.Add(generateRandList(10000));
    }
    Stopwatch stopwatch = new Stopwatch();
    List<Thread> threads = new List<Thread>();

    // Perform selection sorts and measure time
    stopwatch.Start();
    for (int i=0; i < 16; i++) {
        int index = i;
        Thread th = new Thread(() => selectionSort(RandList[index]));
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