<?php

$is_debug_enabled = true;
$is_read_from_file = true;
$data_file = "template.txt";

function debug($msg) {
  global $is_debug_enabled;
  if ($is_debug_enabled) {
    echo $msg . "\n";
  }
}

function dump($obj) {
  global $is_debug_enabled;
  if ($is_debug_enabled) {
    var_dump($obj);
  }
}

function read_lines_from_file() {
  global $data_file;
  $data = file_get_contents($data_file);
  $lines = preg_split("/\r\n|\r|\n/", $data);

  $lines = array_filter(
    $lines,
    function($x) {
      return strlen($x) > 0;
    }
  );

  return $lines;
}

function read_lines_from_stdin() {
  global $data_file;
  $data = file_get_contents("php://stdin");
  $lines = preg_split("/\r\n|\r|\n/", $data);

  $lines = array_filter(
    $lines,
    function($x) {
      return strlen($x) > 0;
    }
  );

  return $lines;
}

function lines_to_list_of_list($lines) {
  $values = array();
  foreach($lines as $row) {
    $values[] = preg_split("/ /", $row);
  }

  return $values;
}

function lines_to_list_of_int_list($lines) {
  $values = array();
  foreach($lines as $row) {
    $values[] = array_map(function($x) {
      return intval($x);
    }, preg_split("/ /", $row));
  }

  return $values;
}

function main() {
  global $is_read_from_file;

  if ($is_read_from_file) {
    $input_lines = read_lines_from_file();
  } else {
    $input_lines = read_lines_from_stdin();
  }

  dump($input_lines);

  $input_values = lines_to_list_of_list($input_lines);
  dump($input_values);

}

main();
?>
