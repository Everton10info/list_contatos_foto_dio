import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static String aplicationId = dotenv.env['APLICATION_ID'] ?? '';
  static String apiKey = dotenv.env['API_KEY'] ?? '';
}
