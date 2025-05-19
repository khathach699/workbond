import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.hr-management.com';
  // static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
