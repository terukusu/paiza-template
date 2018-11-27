import scala.io.Source
import scala.language.reflectiveCalls

object Template {
  val isDebugEnabled = true;
  val isReadFromFile = true;
  val dataFile = "template.txt";

  def using[A <: { def close(): Unit }, B](resource: A)(f: A => B) = try {
     f(resource)
  } finally { resource.close }

  def debug(formatString: String, args: Any*) {
    if (!isDebugEnabled) {
      return;
    }

    printf(formatString + "\n", args: _*);
  }

  def readLinesFromFile(): Array[String] = {
    using (Source.fromFile(dataFile)) { _.getLines.filter(_.length > 0).toArray }
  }

  def readLinesFromStdin(): Array[String] = {
    Source.stdin.getLines.filter(_.length > 0).toArray
  }

  def linesToListOfStrList(lines: Array[String]): Array[Array[String]] = {
    lines.map(_ split " ")
  }

  def linesToListOfIntList(lines: Array[String]): Array[Array[Int]] = {
    lines.map(_.split(" ").map(_.toInt).toArray)
  }

  def main(args: Array[String]){
    val inputLines = if (isReadFromFile)
      readLinesFromFile() else readLinesFromStdin();
    debug("inputLines=%s", inputLines.deep);

    val inputValues = linesToListOfIntList(inputLines);
    debug("inputValues=%s", inputValues.deep);

    // ここからメイン処理
  }
}
