import 'dart:async';
import 'dart:convert';
import 'package:fxtm_trader/src/core/network/network_config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class PriceSocketRemoteDataSource {
  /// Subscribes to a specific symbol.
  Future<void> subscribeToSymbol(String symbol);

  /// A stream of data received from the WebSocket.
  Stream<Map<String, dynamic>> get priceUpdates;
}

class PriceSocketRemoteDataSourceImpl implements PriceSocketRemoteDataSource {
  WebSocketChannel? _channel;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  bool _isConnected = false;

  Future<void> connect() async {
    if (_isConnected) return;

    final uri = _buildWebSocketUri();

    try {
      _channel = WebSocketChannel.connect(uri);
      _isConnected = true;

      _channel?.stream.listen(
        (message) {
          final parsedMessage = _parseMessage(message);
          if (parsedMessage != null) {
            _controller.add(parsedMessage);
          }
        },
        onError: (error) {
          _isConnected = false;
          _controller.addError('WebSocket error: $error');
        },
        onDone: () {
          _isConnected = false;
          _controller.close();
        },
      );
    } catch (e) {
      _isConnected = false;
      throw Exception('Failed to connect to WebSocket: $e');
    }
  }

  @override
  Future<void> subscribeToSymbol(String symbol) async {
    if (!_isConnected) {
      await connect();
    }

    final subscriptionMessage = jsonEncode({
      "type": "subscribe",
      "symbol": symbol,
    });

    _channel?.sink.add(subscriptionMessage);
  }

  @override
  Stream<Map<String, dynamic>> get priceUpdates => _controller.stream;

  void disconnect() {
    _channel?.sink.close();
    _isConnected = false;
    _controller.close();
  }

  Uri _buildWebSocketUri() {
    return Uri.parse(NetworkConfig.webSocketUrl)
        .replace(queryParameters: {'token': NetworkConfig.apiToken});
  }

  Map<String, dynamic>? _parseMessage(dynamic message) {
    try {
      return jsonDecode(message) as Map<String, dynamic>;
    } catch (e) {
      print('Failed to parse WebSocket message: $e');
      return null;
    }
  }
}
