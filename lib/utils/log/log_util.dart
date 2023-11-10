import 'package:home_memo/utils/log/log.dart';
import 'package:logger/logger.dart';

class LogUtil {
  // static final Logger _logger = Logger(
  //   printer: PrefixPrinter(PrettyPrinter()),
  // );

  static final Log _logger = Log.CreateBuilder().withLogPrinter(PrettyPrinter(colors: false)).Build();

  static void v(dynamic message) {
    _logger.v(message);
  }

  static void d(dynamic message) {
    _logger.d(message);
  }

  static void i(dynamic message) {
    _logger.i(message);
  }

  static void w(dynamic message) {
    _logger.w(message);
  }

  static void e(dynamic message) {
    _logger.e(message);
  }

  static void f(dynamic message) {
    _logger.f(message);
  }
}
