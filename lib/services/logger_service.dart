import 'dart:convert';
import 'dart:developer' as developer;

/// abstraction for the dev logger interface
class Logger {

  static log(String message, {level: 0, object}) {
    developer.log(
        message,
        level: level,
        error: (object != null) ? jsonEncode(object) : null,
    );
  }
}