using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Linq;

namespace paiza
{
  class Paiza
  {
    bool isDebugEnabled = true;
    bool isReadFromFile = true;
    String dataFileName = @"template.txt";

    void Debug(Object msg)
    {
      if (isDebugEnabled) {
        Console.WriteLine(msg);
      }
    }

    List<string> ReadLinesFromFile()
    {
      string str;
      using(StreamReader r = new StreamReader(dataFileName, Encoding.Default)) {
        str = r.ReadToEnd();
      }
      List<string> lines = new List<string>(str.Split('\n'));
      lines = lines.Where(x => x.Count() > 0).ToList();

      return lines;
    }

    List<string> ReadLinesFromStdin()
    {
      List<string> lines = new List<string>();

      string line;
      while ((line = Console.ReadLine()) != null && line != "") {
        lines.Add(line);
      }

      return lines;
    }

    List<List<string>> LinesToListOfStrList(List<string> lines)
    {
      return lines.Select(e => new List<string>(e.Split(' '))).ToList();
    }

    List<List<int>> LinesToListOfIntList(List<string> lines)
    {
      return lines.Select(line => new List<int>(line.Split(' ').Select(x => int.Parse(x)))).ToList();
    }

    void Exec() {
      List<string> inputLines;

      if (isReadFromFile) {
        inputLines = ReadLinesFromFile();
      } else {
        inputLines = ReadLinesFromStdin();
      }
      Debug("line count = " + inputLines.Count());
      Debug(string.Join(",", inputLines));

      var inputValues = LinesToListOfIntList(inputLines);
      Debug(string.Join("|", inputValues.Select(x => string.Join(",", x))));
    }

    static void Main()
    {
      new Paiza().Exec();
    }
  }
}
