import 'dart:convert';
import 'dart:developer' as developer;

/// abstraction for the dev logger interface
class Logger {

  static log(String message, {level: 0, object, serialize: true}) {
    var obj = (object != null && serialize == true) ? jsonEncode(object) : object;
    developer.log(
        message,
        level: level,
        error: obj,
    );
  }
}