
import 'package:json_annotation/json_annotation.dart';

part 'forex_symbol_dto.g.dart';
@JsonSerializable()
class ForexSymbolDto {
  final String description;
  final String displaySymbol;
  final String symbol;

  ForexSymbolDto({required this.description, required this.displaySymbol, required this.symbol});

  factory ForexSymbolDto.fromJson(Map<String, dynamic> json) => _$ForexSymbolDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ForexSymbolDtoToJson(this);
}
