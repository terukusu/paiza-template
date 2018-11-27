#import <Foundation/Foundation.h>

BOOL isDebugEnabled = YES;
BOOL isReadFromFile = YES;
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
  NSArray *tmpLines = [contents componentsSeparatedByString:@"\n"];

  NSMutableArray *lines = [@[] mutableCopy];
  for (NSString *row in tmpLines) {
    if ([row length] > 0) {
      [lines addObject: row];
    }
  }

  return [lines copy];
}

NSArray *readLinesFromFile()
{
  NSError *error = nil;
  NSString *contents = [NSString stringWithContentsOfFile: dataFile
    encoding:NSUTF8StringEncoding error:&error];

  if (error != nil) {
    [NSException raise:@"data file can't read." format:@"%@", error];
  }

  NSArray *tmpLines = [contents componentsSeparatedByString:@"\n"];
  NSMutableArray *lines = [@[] mutableCopy];

  for (NSString *row in tmpLines) {
    if ([row length] > 0) {
      [lines addObject: row];
    }
  }

  return [lines copy];
}

NSMutableArray * linesToListOfStrList(NSArray *lines)
{
  NSMutableArray *matrix = [[[NSMutableArray alloc] init] autorelease];

  for (NSString *line in lines) {
    NSArray *row = [line componentsSeparatedByString:@" "];
    [matrix addObject: row];
  }

  return matrix;
}

NSMutableArray * linesToListOfIntList(NSArray *lines)
{
  NSMutableArray *matrix = [[[NSMutableArray alloc] init] autorelease];

  for (NSString *line in lines) {
    NSArray *tmpRow = [line componentsSeparatedByString:@" "];
    NSMutableArray *row = [@[] mutableCopy];
    for (NSString *cell in tmpRow) {
      [row addObject:[NSNumber numberWithInt:[cell intValue]]];
    }
    [matrix addObject: [row copy]];
  }

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
