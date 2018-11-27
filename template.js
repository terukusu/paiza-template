var fs = require('fs');

var isDebugEnabled = true;
var isReadFromFile = true;
var dataFile = "template.txt";

function readFromFile() {
  var text = fs.readFileSync(dataFile, 'utf-8');
  var lines = text.split('\n').map(x => x.trim()).filter(x => x.length > 0);
  return lines;
}

function readFromStdin(exec) {
  process.stdin.setEncoding('utf8');
  var reader = require('readline').createInterface({
      input: process.stdin,
      output: process.stdout
  });

  var lines = [];
  reader.on('line', function (line) {
    line = line.trim();
    if (line.length > 0) {
      lines.push(line);
    }
  });

  reader.on('close', () => {
    exec(lines);
  });
}

function strListToIntList(list) {
  return list.map(x1 => x1.split(' ').map(x2 => Number(x2)))
}

// ファイルと標準入力のきりわけ
function main() {
  if (isReadFromFile) {
    var lines = readFromFile();
    exec(lines);
  } else {
    readFromStdin(exec);
  }
}

function debug(str) {
  if (!isDebugEnabled) {
    return;
  }

  console.log(str)
}

// メイン処理
function exec(lines) {
  debug(lines)

  var input_nums = strListToIntList(lines);
  debug(input_nums)
}

main();
