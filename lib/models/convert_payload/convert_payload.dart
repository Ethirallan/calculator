import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'convert_payload.freezed.dart';
part 'convert_payload.g.dart';

@freezed
abstract class ConvertPayload implements _$ConvertPayload {
  const ConvertPayload._();

  @JsonSerializable(explicitToJson: true)
  factory ConvertPayload({
    required int currencyFrom,
    required int currencyTo,
    required double amount,
  }) = _ConvertPayload;

  factory ConvertPayload.fromJson(Map<String, dynamic> json) => _$ConvertPayloadFromJson(json);
}
