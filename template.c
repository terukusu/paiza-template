#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

int is_debug_enabled = 1;
int is_read_lines_from_file = 1;
const char* DATA_FILE = "template.txt";

int LINE_MAX = 1000;
int COL_MAX = 128;
char input_lines[1000][128];

void hex_dump(const char* str) {
  if (!is_debug_enabled) {
    return;
  }

  int i = 0;
  do {
    printf("%02X", str[i]);
  } while (str[i++] != '\0');
  printf("\n");
}

void debug(const char* fmt, ...) {
  va_list va;

  if (!is_debug_enabled) {
    return;
  }

  va_start(va, fmt);
  vprintf(fmt, va);
  va_end(va);

  printf("\n");
}

int read_lines_from_stdin() {
  char buff[COL_MAX];
  int line;

  line = 0;
  while((fgets(buff,256,stdin))!=NULL){
    buff[strlen(buff)-1] = '\0';
    hex_dump(buff);
    strcpy(input_lines[line], buff);
    line++;
	}

  return 0;
}

int read_lines_from_file() {
  char buff[COL_MAX];
  int line;
  FILE *fp;

  fp = fopen(DATA_FILE,"r");

  if(fp==NULL){
    printf("open filed: %s\n", DATA_FILE);
    return -1;
  }

  line = 0;
  while((fgets(buff,256,fp))!=NULL){
    buff[strlen(buff)-1] = '\0';
    hex_dump(buff);
    strcpy(input_lines[line], buff);
    line++;
	}

  fclose(fp);
  return 0;
}

int  init() {
  int i;

  // clear input line buffer
  for (i=0; i < LINE_MAX; i++) {
    input_lines[i][0] = '\0';
  }

  return 0;
}

int main() {
  int i;
  int num1, num2;
  char* line;

  init();

  if (is_read_lines_from_file) {
    read_lines_from_file();
  } else {
    read_lines_from_stdin();
  }

  for (i=0; i < LINE_MAX; i++) {
    if (input_lines[i][0] == '\0') {
      debug("endof content: line=%d", i);
      break;
    }
    debug("%03d: %s", i, input_lines[i]);
  }

  line = input_lines[0];

  // num1 = atoi(strtok(line, " "));
  // num2 = atoi(strtok(NULL, " "));
  //
  // debug("num1=%d, num2=%d", num1, num2);


  return 0;
}
