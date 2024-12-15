import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fxtm_trader/src/features/forex_history/data/models/candle_model.dart';

abstract class CandleLocalDataSource {
  Future<List<CandleModel>> loadCandleData();
}

class CandleLocalDataSourceImpl implements CandleLocalDataSource {
  final String jsonFilePath;

  CandleLocalDataSourceImpl({required this.jsonFilePath});

  @override
  Future<List<CandleModel>> loadCandleData() async {
    // Load the JSON file from assets
    final jsonString = await rootBundle.loadString(jsonFilePath);

    // Parse the JSON string into a Map
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // Convert the JSON data into a list of CandleModel objects
    return CandleModel.fromResponse(jsonMap);
  }
}
