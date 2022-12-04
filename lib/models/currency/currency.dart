import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
abstract class Currency implements _$Currency {
  const Currency._();

  @JsonSerializable(explicitToJson: true)
  factory Currency({
    required int id,
    required String label,
    required int code,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
}
