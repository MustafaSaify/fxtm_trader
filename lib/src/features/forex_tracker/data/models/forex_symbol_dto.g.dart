// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_symbol_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForexSymbolDto _$ForexSymbolDtoFromJson(Map<String, dynamic> json) =>
    ForexSymbolDto(
      description: json['description'] as String,
      displaySymbol: json['displaySymbol'] as String,
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$ForexSymbolDtoToJson(ForexSymbolDto instance) =>
    <String, dynamic>{
      'description': instance.description,
      'displaySymbol': instance.displaySymbol,
      'symbol': instance.symbol,
    };
