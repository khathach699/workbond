import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppApi {
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8080/api/';
  // static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
