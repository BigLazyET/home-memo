import 'dart:js_util';

import 'package:home_memo/utils/log/log_builder.dart';
import 'package:logger/logger.dart';

class Log {
  static final Map<LogOutput, Logger> _loggers = {};

  Log(
      {required Level level,
      required LogFilter logFilter,
      required LogPrinter logPrinter,
      required List<LogOutput> logOutputs}) {
    _loggers.clear();
    level = level;
    for (var logOutput in logOutputs) {
      _loggers.addAll({logOutput: Logger(level: level, filter: logFilter, printer: logPrinter, output: logOutput)});
    }
  }

  static LogBuilder CreateBuilder() {
    return LogBuilder();
  }

  ///只打印到控制台
  void n(dynamic message) {
    LogOutput? logOutput = _loggers.keys.whereType<ConsoleOutput>().firstOrNull;
    if (logOutput == null) return;
    var logger = _loggers[logOutput]!;
    logger.i(message);
  }

  void v(dynamic message) {
    for (var logger in _loggers.values) {
      logger.v(message);
    }
  }

  void d(dynamic message) {
    for (var logger in _loggers.values) {
      logger.d(message);
    }
  }

  void i(dynamic message) {
    for (var logger in _loggers.values) {
      logger.i(message);
    }
  }

  void w(dynamic message) {
    for (var logger in _loggers.values) {
      logger.w(message);
    }
  }

  void e(dynamic message) {
    for (var logger in _loggers.values) {
      logger.e(message);
    }
  }

  void f(dynamic message) {
    for (var logger in _loggers.values) {
      logger.f(message);
    }
  }
}
