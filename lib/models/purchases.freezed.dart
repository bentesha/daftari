// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'purchases.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Purchases _$PurchasesFromJson(Map<String, dynamic> json) {
  return _Purchases.fromJson(json);
}

/// @nodoc
class _$PurchasesTearOff {
  const _$PurchasesTearOff();

  _Purchases call(
      {String id = '',
      String documentId = '',
      double sort = 0.0,
      double quantity = 0.0,
      double unitPrice = 0.0,
      double total = 0.0,
      String productId = '',
      String movementId = ''}) {
    return _Purchases(
      id: id,
      documentId: documentId,
      sort: sort,
      quantity: quantity,
      unitPrice: unitPrice,
      total: total,
      productId: productId,
      movementId: movementId,
    );
  }

  Purchases fromJson(Map<String, Object?> json) {
    return Purchases.fromJson(json);
  }
}

/// @nodoc
const $Purchases = _$PurchasesTearOff();

/// @nodoc
mixin _$Purchases {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  double get sort => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get movementId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchasesCopyWith<Purchases> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasesCopyWith<$Res> {
  factory $PurchasesCopyWith(Purchases value, $Res Function(Purchases) then) =
      _$PurchasesCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String documentId,
      double sort,
      double quantity,
      double unitPrice,
      double total,
      String productId,
      String movementId});
}

/// @nodoc
class _$PurchasesCopyWithImpl<$Res> implements $PurchasesCopyWith<$Res> {
  _$PurchasesCopyWithImpl(this._value, this._then);

  final Purchases _value;
  // ignore: unused_field
  final $Res Function(Purchases) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? documentId = freezed,
    Object? sort = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? total = freezed,
    Object? productId = freezed,
    Object? movementId = freezed,
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
      sort: sort == freezed
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: unitPrice == freezed
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      movementId: movementId == freezed
          ? _value.movementId
          : movementId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PurchasesCopyWith<$Res> implements $PurchasesCopyWith<$Res> {
  factory _$PurchasesCopyWith(
          _Purchases value, $Res Function(_Purchases) then) =
      __$PurchasesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String documentId,
      double sort,
      double quantity,
      double unitPrice,
      double total,
      String productId,
      String movementId});
}

/// @nodoc
class __$PurchasesCopyWithImpl<$Res> extends _$PurchasesCopyWithImpl<$Res>
    implements _$PurchasesCopyWith<$Res> {
  __$PurchasesCopyWithImpl(_Purchases _value, $Res Function(_Purchases) _then)
      : super(_value, (v) => _then(v as _Purchases));

  @override
  _Purchases get _value => super._value as _Purchases;

  @override
  $Res call({
    Object? id = freezed,
    Object? documentId = freezed,
    Object? sort = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? total = freezed,
    Object? productId = freezed,
    Object? movementId = freezed,
  }) {
    return _then(_Purchases(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String,
      sort: sort == freezed
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: unitPrice == freezed
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      productId: productId == freezed
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      movementId: movementId == freezed
          ? _value.movementId
          : movementId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Purchases extends _Purchases {
  const _$_Purchases(
      {this.id = '',
      this.documentId = '',
      this.sort = 0.0,
      this.quantity = 0.0,
      this.unitPrice = 0.0,
      this.total = 0.0,
      this.productId = '',
      this.movementId = ''})
      : super._();

  factory _$_Purchases.fromJson(Map<String, dynamic> json) =>
      _$$_PurchasesFromJson(json);

  @JsonKey()
  @override
  final String id;
  @JsonKey()
  @override
  final String documentId;
  @JsonKey()
  @override
  final double sort;
  @JsonKey()
  @override
  final double quantity;
  @JsonKey()
  @override
  final double unitPrice;
  @JsonKey()
  @override
  final double total;
  @JsonKey()
  @override
  final String productId;
  @JsonKey()
  @override
  final String movementId;

  @override
  String toString() {
    return 'Purchases(id: $id, documentId: $documentId, sort: $sort, quantity: $quantity, unitPrice: $unitPrice, total: $total, productId: $productId, movementId: $movementId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Purchases &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.documentId, documentId) &&
            const DeepCollectionEquality().equals(other.sort, sort) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.unitPrice, unitPrice) &&
            const DeepCollectionEquality().equals(other.total, total) &&
            const DeepCollectionEquality().equals(other.productId, productId) &&
            const DeepCollectionEquality()
                .equals(other.movementId, movementId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(documentId),
      const DeepCollectionEquality().hash(sort),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(unitPrice),
      const DeepCollectionEquality().hash(total),
      const DeepCollectionEquality().hash(productId),
      const DeepCollectionEquality().hash(movementId));

  @JsonKey(ignore: true)
  @override
  _$PurchasesCopyWith<_Purchases> get copyWith =>
      __$PurchasesCopyWithImpl<_Purchases>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchasesToJson(this);
  }
}

abstract class _Purchases extends Purchases {
  const factory _Purchases(
      {String id,
      String documentId,
      double sort,
      double quantity,
      double unitPrice,
      double total,
      String productId,
      String movementId}) = _$_Purchases;
  const _Purchases._() : super._();

  factory _Purchases.fromJson(Map<String, dynamic> json) =
      _$_Purchases.fromJson;

  @override
  String get id;
  @override
  String get documentId;
  @override
  double get sort;
  @override
  double get quantity;
  @override
  double get unitPrice;
  @override
  double get total;
  @override
  String get productId;
  @override
  String get movementId;
  @override
  @JsonKey(ignore: true)
  _$PurchasesCopyWith<_Purchases> get copyWith =>
      throw _privateConstructorUsedError;
}
