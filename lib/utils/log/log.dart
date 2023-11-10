import 'package:home_memo/utils/log/log_builder.dart';
import 'package:logger/logger.dart';

class Log {
  static final List<Logger> _loggers = [];

  Log(
      {required Level level,
      required LogFilter logFilter,
      required LogPrinter logPrinter,
      required List<LogOutput> logOutputs}) {
    _loggers.clear();
    for (var logOutput in logOutputs) {
      _loggers.add(Logger(level: level, filter: logFilter, printer: logPrinter, output: logOutput));
    }
  }

  static LogBuilder CreateBuilder() {
    return LogBuilder();
  }

  static void LogCommon(dynamic message) {}

  void v(dynamic message) {
    for (var logger in _loggers) {
      logger.v(message);
    }
  }

  void d(dynamic message) {
    for (var logger in _loggers) {
      logger.d(message);
    }
  }

  void i(dynamic message) {
    for (var logger in _loggers) {
      logger.i(message);
    }
  }

  void w(dynamic message) {
    for (var logger in _loggers) {
      logger.w(message);
    }
  }

  void e(dynamic message) {
    for (var logger in _loggers) {
      logger.e(message);
    }
  }

  void f(dynamic message) {
    for (var logger in _loggers) {
      logger.f(message);
    }
  }
}
