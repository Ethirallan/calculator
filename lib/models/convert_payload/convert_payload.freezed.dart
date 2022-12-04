// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'convert_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConvertPayload _$ConvertPayloadFromJson(Map<String, dynamic> json) {
  return _ConvertPayload.fromJson(json);
}

/// @nodoc
mixin _$ConvertPayload {
  int get currencyFrom => throw _privateConstructorUsedError;
  int get currencyTo => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConvertPayloadCopyWith<ConvertPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConvertPayloadCopyWith<$Res> {
  factory $ConvertPayloadCopyWith(
          ConvertPayload value, $Res Function(ConvertPayload) then) =
      _$ConvertPayloadCopyWithImpl<$Res, ConvertPayload>;
  @useResult
  $Res call({int currencyFrom, int currencyTo, double amount});
}

/// @nodoc
class _$ConvertPayloadCopyWithImpl<$Res, $Val extends ConvertPayload>
    implements $ConvertPayloadCopyWith<$Res> {
  _$ConvertPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyFrom = null,
    Object? currencyTo = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      currencyFrom: null == currencyFrom
          ? _value.currencyFrom
          : currencyFrom // ignore: cast_nullable_to_non_nullable
              as int,
      currencyTo: null == currencyTo
          ? _value.currencyTo
          : currencyTo // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConvertPayloadCopyWith<$Res>
    implements $ConvertPayloadCopyWith<$Res> {
  factory _$$_ConvertPayloadCopyWith(
          _$_ConvertPayload value, $Res Function(_$_ConvertPayload) then) =
      __$$_ConvertPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currencyFrom, int currencyTo, double amount});
}

/// @nodoc
class __$$_ConvertPayloadCopyWithImpl<$Res>
    extends _$ConvertPayloadCopyWithImpl<$Res, _$_ConvertPayload>
    implements _$$_ConvertPayloadCopyWith<$Res> {
  __$$_ConvertPayloadCopyWithImpl(
      _$_ConvertPayload _value, $Res Function(_$_ConvertPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyFrom = null,
    Object? currencyTo = null,
    Object? amount = null,
  }) {
    return _then(_$_ConvertPayload(
      currencyFrom: null == currencyFrom
          ? _value.currencyFrom
          : currencyFrom // ignore: cast_nullable_to_non_nullable
              as int,
      currencyTo: null == currencyTo
          ? _value.currencyTo
          : currencyTo // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ConvertPayload extends _ConvertPayload with DiagnosticableTreeMixin {
  _$_ConvertPayload(
      {required this.currencyFrom,
      required this.currencyTo,
      required this.amount})
      : super._();

  factory _$_ConvertPayload.fromJson(Map<String, dynamic> json) =>
      _$$_ConvertPayloadFromJson(json);

  @override
  final int currencyFrom;
  @override
  final int currencyTo;
  @override
  final double amount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConvertPayload(currencyFrom: $currencyFrom, currencyTo: $currencyTo, amount: $amount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConvertPayload'))
      ..add(DiagnosticsProperty('currencyFrom', currencyFrom))
      ..add(DiagnosticsProperty('currencyTo', currencyTo))
      ..add(DiagnosticsProperty('amount', amount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConvertPayload &&
            (identical(other.currencyFrom, currencyFrom) ||
                other.currencyFrom == currencyFrom) &&
            (identical(other.currencyTo, currencyTo) ||
                other.currencyTo == currencyTo) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currencyFrom, currencyTo, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConvertPayloadCopyWith<_$_ConvertPayload> get copyWith =>
      __$$_ConvertPayloadCopyWithImpl<_$_ConvertPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConvertPayloadToJson(
      this,
    );
  }
}

abstract class _ConvertPayload extends ConvertPayload {
  factory _ConvertPayload(
      {required final int currencyFrom,
      required final int currencyTo,
      required final double amount}) = _$_ConvertPayload;
  _ConvertPayload._() : super._();

  factory _ConvertPayload.fromJson(Map<String, dynamic> json) =
      _$_ConvertPayload.fromJson;

  @override
  int get currencyFrom;
  @override
  int get currencyTo;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$_ConvertPayloadCopyWith<_$_ConvertPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
