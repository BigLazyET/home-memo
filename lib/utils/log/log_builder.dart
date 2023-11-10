import 'package:home_memo/utils/log/log.dart';
import 'package:logger/logger.dart';

class LogBuilder {
  Level _level = Level.debug;
  LogFilter _logFilter = DevelopmentFilter();
  LogPrinter _logPrinter = PrettyPrinter();
  final List<LogOutput> _logOutputs = [ConsoleOutput()];

  LogBuilder withLoglevel(Level level) {
    _level = level;
    return this;
  }

  LogBuilder withLogFilter(LogFilter logFilter) {
    _logFilter = logFilter;
    return this;
  }

  LogBuilder withLogPrinter(LogPrinter logPrinter) {
    _logPrinter = logPrinter;
    return this;
  }

  LogBuilder withLogOutput(LogOutput logOutput) {
    if (!_logOutputs.contains(logOutput)) {
      _logOutputs.add(logOutput);
    }
    return this;
  }

  Log Build() {
    return Log(level: _level, logFilter: _logFilter, logPrinter: _logPrinter, logOutputs: _logOutputs);
  }
}
