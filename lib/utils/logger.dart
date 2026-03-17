import 'package:logger/logger.dart';

class LoggerUtils {
  LoggerUtils._();

  static final Logger _logger = Logger();

  static void t<T>(T message) {
    _logger.t(message);
  }

  static void d<T>(T message) {
    _logger.d(message);
  }

  static void i<T>(T message) {
    _logger.i(message);
  }

  static void w<T>(T message) {
    _logger.w(message);
  }

  static void e<T>(T message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}