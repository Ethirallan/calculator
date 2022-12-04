// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConvertPayload _$$_ConvertPayloadFromJson(Map<String, dynamic> json) =>
    _$_ConvertPayload(
      currencyFrom: json['currencyFrom'] as int,
      currencyTo: json['currencyTo'] as int,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ConvertPayloadToJson(_$_ConvertPayload instance) =>
    <String, dynamic>{
      'currencyFrom': instance.currencyFrom,
      'currencyTo': instance.currencyTo,
      'amount': instance.amount,
    };
