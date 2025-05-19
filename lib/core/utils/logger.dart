import 'package:logger/web.dart';

final _logger = Logger();

void log(String message) => _logger.d(message);
void error(String message) => _logger.e(message);
