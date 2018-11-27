#!/usr/bin/ruby

IS_DEBUG_ENABLED = true;
IS_READ_FROM_FILE = true;
DATA_FILE = "template.txt";

def read_lines_from_file()
  File.open(DATA_FILE) do |file|
    return file.read.split("\n")
  end
end

def read_lines_from_stdin()
  return $stdin.read.split("\n").select { |line| line.length > 0 }
end

def lines_to_list_of_str_list(lines)
  return lines.map { |line| line.split(" ") }
end

def lines_to_list_of_int_list(lines)
  return lines.map { |line|
    line.split(" ").map { |e2| e2.to_i }
  }
end

def debug(msg, *args)
  if IS_DEBUG_ENABLED then
    printf(msg+"\n", *args)
  end
end

def dump(obj)
  if IS_DEBUG_ENABLED then
    p (obj)
  end
end

def main()
  if IS_READ_FROM_FILE then
    input_lines = read_lines_from_file()
  else
    input_lines = read_lines_from_stdin()
  end

  debug("input_lines=")
  dump(input_lines)

  input_values = lines_to_list_of_int_list(input_lines)
  debug("input_values=")
  dump(input_values)

end

main()
