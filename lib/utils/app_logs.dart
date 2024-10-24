import 'dart:developer';

void appLogs(value) {
  try {
    throw Exception();
  } catch (e, stackTrace) {
    final traceString = stackTrace.toString().split('\n')[1];
    final filePathRegex = RegExp(r'(/[^:]+):(\d+):\d+');
    final match = filePathRegex.firstMatch(traceString);
    if (match != null) {
      final filePath = match.group(1);
      final lineNumber = match.group(2);
      log('$value :::: $filePath:$lineNumber ');
    }
  }
}
