// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../write_off.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WriteOff _$WriteOffFromJson(Map<String, dynamic> json) {
  return _WriteOff.fromJson(json);
}

/// @nodoc
class _$WriteOffTearOff {
  const _$WriteOffTearOff();

  _WriteOff call(
      {String id = '',
      String documentId = '',
      String productId = '',
      double quantity = 0.0}) {
    return _WriteOff(
      id: id,
      documentId: documentId,
      productId: productId,
      quantity: quantity,
    );
  }

  WriteOff fromJson(Map<String, Object?> json) {
    return WriteOff.fromJson(json);
  }
}

/// @nodoc
const $WriteOff = _$WriteOffTearOff();

/// @nodoc
mixin _$WriteOff {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WriteOffCopyWith<WriteOff> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WriteOffCopyWith<$Res> {
  factory $WriteOffCopyWith(WriteOff value, $Res Function(WriteOff) then) =
      _$WriteOffCopyWithImpl<$Res>;
  $Res call({String id, String documentId, String productId, double quantity});
}

/// @nodoc
class _$WriteOffCopyWithImpl<$Res> implements $WriteOffCopyWith<$Res> {
  _$WriteOffCopyWithImpl(this._value, this._then);

  final WriteOff _value;
  // ignore: unused_field
  final $Res Function(WriteOff) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? documentId = freezed,
    Object? productId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$WriteOffCopyWith<$Res> implements $WriteOffCopyWith<$Res> {
  factory _$WriteOffCopyWith(_WriteOff value, $Res Function(_WriteOff) then) =
      __$WriteOffCopyWithImpl<$Res>;
  @override
  $Res call({String id, String documentId, String productId, double quantity});
}

/// @nodoc
class __$WriteOffCopyWithImpl<$Res> extends _$WriteOffCopyWithImpl<$Res>
    implements _$WriteOffCopyWith<$Res> {
  __$WriteOffCopyWithImpl(_WriteOff _value, $Res Function(_WriteOff) _then)
      : super(_value, (v) => _then(v as _WriteOff));

  @override
  _WriteOff get _value => super._value as _WriteOff;

  @override
  $Res call({
    Object? id = freezed,
    Object? documentId = freezed,
    Object? productId = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_WriteOff(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WriteOff extends _WriteOff {
  const _$_WriteOff(
      {this.id = '',
      this.documentId = '',
      this.productId = '',
      this.quantity = 0.0})
      : super._();

  factory _$_WriteOff.fromJson(Map<String, dynamic> json) =>
      _$$_WriteOffFromJson(json);

  @JsonKey()
  @override
  final String id;
  @JsonKey()
  @override
  final String documentId;
  @JsonKey()
  @override
  final String productId;
  @JsonKey()
  @override
  final double quantity;

  @override
  String toString() {
    return 'WriteOff(id: $id, documentId: $documentId, productId: $productId, quantity: $quantity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WriteOff &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.documentId, documentId) &&
            const DeepCollectionEquality().equals(other.productId, productId) &&
            const DeepCollectionEquality().equals(other.quantity, quantity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(documentId),
      const DeepCollectionEquality().hash(productId),
      const DeepCollectionEquality().hash(quantity));

  @JsonKey(ignore: true)
  @override
  _$WriteOffCopyWith<_WriteOff> get copyWith =>
      __$WriteOffCopyWithImpl<_WriteOff>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WriteOffToJson(this);
  }
}

abstract class _WriteOff extends WriteOff {
  const factory _WriteOff(
      {String id,
      String documentId,
      String productId,
      double quantity}) = _$_WriteOff;
  const _WriteOff._() : super._();

  factory _WriteOff.fromJson(Map<String, dynamic> json) = _$_WriteOff.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  String get productId;
  @override
  double get quantity;
  @override
  @JsonKey(ignore: true)
  _$WriteOffCopyWith<_WriteOff> get copyWith =>
      throw _privateConstructorUsedError;
}
