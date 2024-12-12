import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConfig {
  static String baseUrl = dotenv.env['host']!;
  static String apiToken = dotenv.env['apiToken']!;
  static String webSocketUrl = dotenv.env['webSocketUrl']!;
}
