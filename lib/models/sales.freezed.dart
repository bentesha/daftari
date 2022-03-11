// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sales.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sales _$SalesFromJson(Map<String, dynamic> json) {
  return _Sales.fromJson(json);
}

/// @nodoc
class _$SalesTearOff {
  const _$SalesTearOff();

  _Sales call(
      {String id = '',
      String documentId = '',
      double sort = 0.0,
      double quantity = 0.0,
      double unitPrice = 0.0,
      double total = 0.0,
      String productId = ''}) {
    return _Sales(
      id: id,
      documentId: documentId,
      sort: sort,
      quantity: quantity,
      unitPrice: unitPrice,
      total: total,
      productId: productId,
    );
  }

  Sales fromJson(Map<String, Object?> json) {
    return Sales.fromJson(json);
  }
}

/// @nodoc
const $Sales = _$SalesTearOff();

/// @nodoc
mixin _$Sales {
  String get id => throw _privateConstructorUsedError;
  String get documentId => throw _privateConstructorUsedError;
  double get sort => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesCopyWith<Sales> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesCopyWith<$Res> {
  factory $SalesCopyWith(Sales value, $Res Function(Sales) then) =
      _$SalesCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String documentId,
      double sort,
      double quantity,
      double unitPrice,
      double total,
      String productId});
}

/// @nodoc
class _$SalesCopyWithImpl<$Res> implements $SalesCopyWith<$Res> {
  _$SalesCopyWithImpl(this._value, this._then);

  final Sales _value;
  // ignore: unused_field
  final $Res Function(Sales) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? documentId = freezed,
    Object? sort = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? total = freezed,
    Object? productId = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$SalesCopyWith<$Res> implements $SalesCopyWith<$Res> {
  factory _$SalesCopyWith(_Sales value, $Res Function(_Sales) then) =
      __$SalesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String documentId,
      double sort,
      double quantity,
      double unitPrice,
      double total,
      String productId});
}

/// @nodoc
class __$SalesCopyWithImpl<$Res> extends _$SalesCopyWithImpl<$Res>
    implements _$SalesCopyWith<$Res> {
  __$SalesCopyWithImpl(_Sales _value, $Res Function(_Sales) _then)
      : super(_value, (v) => _then(v as _Sales));

  @override
  _Sales get _value => super._value as _Sales;

  @override
  $Res call({
    Object? id = freezed,
    Object? documentId = freezed,
    Object? sort = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? total = freezed,
    Object? productId = freezed,
  }) {
    return _then(_Sales(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sales extends _Sales {
  const _$_Sales(
      {this.id = '',
      this.documentId = '',
      this.sort = 0.0,
      this.quantity = 0.0,
      this.unitPrice = 0.0,
      this.total = 0.0,
      this.productId = ''})
      : super._();

  factory _$_Sales.fromJson(Map<String, dynamic> json) =>
      _$$_SalesFromJson(json);

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

  @override
  String toString() {
    return 'Sales(id: $id, documentId: $documentId, sort: $sort, quantity: $quantity, unitPrice: $unitPrice, total: $total, productId: $productId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Sales &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.documentId, documentId) &&
            const DeepCollectionEquality().equals(other.sort, sort) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.unitPrice, unitPrice) &&
            const DeepCollectionEquality().equals(other.total, total) &&
            const DeepCollectionEquality().equals(other.productId, productId));
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
      const DeepCollectionEquality().hash(productId));

  @JsonKey(ignore: true)
  @override
  _$SalesCopyWith<_Sales> get copyWith =>
      __$SalesCopyWithImpl<_Sales>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SalesToJson(this);
  }
}

abstract class _Sales extends Sales {
  const factory _Sales(
      {String id,
      String documentId,
      double sort,
      double quantity,
      double unitPrice,
      double total,
      String productId}) = _$_Sales;
  const _Sales._() : super._();

  factory _Sales.fromJson(Map<String, dynamic> json) = _$_Sales.fromJson;

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
  @JsonKey(ignore: true)
  _$SalesCopyWith<_Sales> get copyWith => throw _privateConstructorUsedError;
}
