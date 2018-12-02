import Foundation

let isDebugEnabled = true
let isReadFromFile = true
let dataFile = "template.txt"

func debug(_ object: Any) {
  if !isDebugEnabled {
    return
  }

  print(object)
}

func readLinesFromFile() -> [String] {
  let fileText = try! String(contentsOf: URL(fileURLWithPath: dataFile))
  let lines = fileText.components(separatedBy: "\n").filter {$0.count > 0}
  return lines;
}

func readLinesFromStdin() -> [String] {
  var lines:[String] = []

  while let line = readLine() {
    if line.count > 0 {
      lines.append(line)
    }
  }

  return lines
}

func linesToStrList(_ lines: [String]) -> [[String]]{
  return lines.map {$0.components(separatedBy: " ")}
}

func linesToIntList(_ lines: [String]) -> [[Int]]{
  return lines.map {$0.components(separatedBy: " ").map{Int($0)!}}
}

func main() {
  let inputLines: [String]
  if isReadFromFile {
    inputLines = readLinesFromFile()
  } else {
    inputLines = readLinesFromStdin()
  }
  debug("inputLines=\(inputLines)");

  // ここからメイン処理
  // let inputValues = linesToIntList(inputLines)
  // debug("inputValues=\(inputValues)")
}

main()
