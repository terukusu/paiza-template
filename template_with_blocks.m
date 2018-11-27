#import <Foundation/Foundation.h>

BOOL isDebugEnabled = TRUE;
BOOL isReadFromFile = TRUE;
NSString *dataFile = @"template.txt";

void debug(NSString *formatString, ...)
{
  if (!isDebugEnabled) {
    return;
  }

  NSString *contents;
  va_list args;
  va_start(args, formatString);
  contents = [[[NSString alloc] initWithFormat:formatString arguments:args] autorelease];
  va_end(args);

  NSLog(@"%@", contents);
}

void print(NSString *formatString, ...) {
  NSString *contents;
  va_list args;
  va_start(args, formatString);
  contents = [[[NSString alloc] initWithFormat:
    [formatString stringByAppendingString:@"\n"] arguments:args] autorelease];
  va_end(args);

  [[NSFileHandle fileHandleWithStandardOutput] writeData:
    [contents dataUsingEncoding: NSUTF8StringEncoding]];
}

NSArray *readLinesFromStdin()
{
  NSData *data = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
  NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
  NSArray *lines = [contents componentsSeparatedByString:@"\n"];

  lines = [lines filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
    ^BOOL(id str, NSDictionary *bindings) {
    return [str length] > 0;
  }]];

  return lines;
}

NSArray *readLinesFromFile()
{
  NSError *error;
  NSString *contents = [NSString stringWithContentsOfFile: dataFile
    encoding:NSUTF8StringEncoding error:&error];

  if (error != nil) {
    [NSException raise:@"data file can't read." format:@"%@", error];
  }

  NSArray *lines = [contents componentsSeparatedByString:@"\n"];

  lines = [lines filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
    ^BOOL(id str, NSDictionary *bindings) {
    return [str length] > 0;
  }]];

  return lines;
}

NSMutableArray * linesToListOfStrList(NSArray *lines)
{
  NSMutableArray *matrix = [[[NSMutableArray alloc] init] autorelease];

  [lines enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
    NSArray *row = [str componentsSeparatedByString:@" "];
    [matrix addObject: row];
  }];

  return matrix;
}

NSMutableArray * linesToListOfIntList(NSArray *lines)
{
  NSMutableArray *matrix = [[[NSMutableArray alloc] init] autorelease];

  [lines enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
    NSArray *tmpRow = [str componentsSeparatedByString:@" "];
    NSMutableArray *row = [[[NSMutableArray alloc] init] autorelease];

    [tmpRow enumerateObjectsUsingBlock:^(NSString *str2, NSUInteger idx2, BOOL *stop2) {
      [row addObject:[NSNumber numberWithInt:[str2 intValue]]];
    }];

    [matrix addObject: [row copy]];
  }];

  return matrix;
}

int main(int argc, char** argv)
{
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  NSArray *inputLines;
  if (isReadFromFile) {
    inputLines = readLinesFromFile();
  } else {
    inputLines = readLinesFromStdin();
  }
  debug(@"inputLines=%@", inputLines);

  NSArray *inputValues = linesToListOfIntList(inputLines);
  debug(@"inputValues=%@", inputValues);

  [pool release];

  return 0;
}
