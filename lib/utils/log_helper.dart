import 'package:logger/logger.dart';

const String _default_tag = "Log-monitor";

var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

void logV(String msg, {String tag = _default_tag}) {
  _logger.v("$tag :: $msg");
}

void logD(String msg, {String tag = _default_tag}) {
  _logger.d("$tag :: $msg");
}

void logI(String msg, {String tag = _default_tag}) {
  _logger.i("$tag :: $msg");
}

void logW(String msg, {String tag = _default_tag}) {
  _logger.w("$tag :: $msg");
}

void logE(String msg, {String tag = _default_tag}) {
  _logger.e("$tag :: $msg");
}