// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'item_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ItemSupplementsTearOff {
  const _$ItemSupplementsTearOff();

  _ItemSupplements call(
      {required String title,
      required String unit,
      required String unitPrice,
      required String quantity,
      required Map<String, String?> errors}) {
    return _ItemSupplements(
      title: title,
      unit: unit,
      unitPrice: unitPrice,
      quantity: quantity,
      errors: errors,
    );
  }
}

/// @nodoc
const $ItemSupplements = _$ItemSupplementsTearOff();

/// @nodoc
mixin _$ItemSupplements {
  String get title => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  String get unitPrice => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemSupplementsCopyWith<ItemSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemSupplementsCopyWith<$Res> {
  factory $ItemSupplementsCopyWith(
          ItemSupplements value, $Res Function(ItemSupplements) then) =
      _$ItemSupplementsCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String unit,
      String unitPrice,
      String quantity,
      Map<String, String?> errors});
}

/// @nodoc
class _$ItemSupplementsCopyWithImpl<$Res>
    implements $ItemSupplementsCopyWith<$Res> {
  _$ItemSupplementsCopyWithImpl(this._value, this._then);

  final ItemSupplements _value;
  // ignore: unused_field
  final $Res Function(ItemSupplements) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? unit = freezed,
    Object? unitPrice = freezed,
    Object? quantity = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: unitPrice == freezed
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc
abstract class _$ItemSupplementsCopyWith<$Res>
    implements $ItemSupplementsCopyWith<$Res> {
  factory _$ItemSupplementsCopyWith(
          _ItemSupplements value, $Res Function(_ItemSupplements) then) =
      __$ItemSupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String unit,
      String unitPrice,
      String quantity,
      Map<String, String?> errors});
}

/// @nodoc
class __$ItemSupplementsCopyWithImpl<$Res>
    extends _$ItemSupplementsCopyWithImpl<$Res>
    implements _$ItemSupplementsCopyWith<$Res> {
  __$ItemSupplementsCopyWithImpl(
      _ItemSupplements _value, $Res Function(_ItemSupplements) _then)
      : super(_value, (v) => _then(v as _ItemSupplements));

  @override
  _ItemSupplements get _value => super._value as _ItemSupplements;

  @override
  $Res call({
    Object? title = freezed,
    Object? unit = freezed,
    Object? unitPrice = freezed,
    Object? quantity = freezed,
    Object? errors = freezed,
  }) {
    return _then(_ItemSupplements(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: unitPrice == freezed
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc

class _$_ItemSupplements extends _ItemSupplements {
  const _$_ItemSupplements(
      {required this.title,
      required this.unit,
      required this.unitPrice,
      required this.quantity,
      required this.errors})
      : super._();

  @override
  final String title;
  @override
  final String unit;
  @override
  final String unitPrice;
  @override
  final String quantity;
  @override
  final Map<String, String?> errors;

  @override
  String toString() {
    return 'ItemSupplements(title: $title, unit: $unit, unitPrice: $unitPrice, quantity: $quantity, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ItemSupplements &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality().equals(other.unitPrice, unitPrice) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(unitPrice),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(errors));

  @JsonKey(ignore: true)
  @override
  _$ItemSupplementsCopyWith<_ItemSupplements> get copyWith =>
      __$ItemSupplementsCopyWithImpl<_ItemSupplements>(this, _$identity);
}

abstract class _ItemSupplements extends ItemSupplements {
  const factory _ItemSupplements(
      {required String title,
      required String unit,
      required String unitPrice,
      required String quantity,
      required Map<String, String?> errors}) = _$_ItemSupplements;
  const _ItemSupplements._() : super._();

  @override
  String get title;
  @override
  String get unit;
  @override
  String get unitPrice;
  @override
  String get quantity;
  @override
  Map<String, String?> get errors;
  @override
  @JsonKey(ignore: true)
  _$ItemSupplementsCopyWith<_ItemSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
