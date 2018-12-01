package main

import (
  "bufio"
  "fmt"
  "os"
  "strconv"
  "strings"
)

var isDebugEnabled = true
var isReadFromFile = true
var dataFile = "template.txt"

func debug(formatString string, args ...interface{}) {
  if ! isDebugEnabled {
    return
  }

  fmt.Printf(formatString + "\n", args...)
}

func readLinesFromFile() []string {
  f, err := os.Open(dataFile);

  if err != nil {
    fmt.Fprintf(os.Stderr, "could not read file: %v\n", dataFile, err)
    os.Exit(1)
  }

  defer f.Close()

  scanner := bufio.NewScanner(f)
  lines := []string{}
  for scanner.Scan() {
    line := scanner.Text()
    if (len(line) > 0) {
      lines = append(lines, line)
    }
  }

  return lines;
}

func readLinesFromStdin() []string {
  scanner := bufio.NewScanner(os.Stdin)
  lines := []string{}
  for scanner.Scan() {
    line := scanner.Text()
    if (len(line) > 0) {
      lines = append(lines, line)
    }
  }

  return lines;
}

func linesToStrList(lines []string) [][]string {
  var values [][]string

  for _, line := range(lines) {
    values = append(values, strings.Split(line, " "))
  }

  return values
}

func linesToIntList(lines []string) [][]int {
  var values [][]int

  for _, line := range(lines) {
    strValues := strings.Split(line, " ")
    var intValues []int

    for _, v := range(strValues) {
      intValue, _ := strconv.Atoi(v)
      intValues = append(intValues, intValue)
    }

    values = append(values, intValues)
  }

  return values
}

func main() {
  var inputLines []string

  if isReadFromFile {
    inputLines = readLinesFromFile()
  } else {
    inputLines = readLinesFromStdin()
  }

  debug("inputLines=[%s]\n", strings.Join(inputLines, ","))

  inputValues := linesToIntList(inputLines)
  debug("inputValues=%s\n", inputValues)
}
