import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkConfig {
  static String baseUrl = dotenv.env['API_HOST']!;
  static String apiToken = dotenv.env['API_KEY']!;
  static String webSocketUrl = dotenv.env['WEBSOCKET_URL']!;
}
