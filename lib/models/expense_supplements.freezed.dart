// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expense_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ExpenseSupplementsTearOff {
  const _$ExpenseSupplementsTearOff();

  _ExpenseSupplements call(
      {required Map<String, String?> errors,
      required String amount,
      required DateTime date,
      String? notes,
      required String categoryId}) {
    return _ExpenseSupplements(
      errors: errors,
      amount: amount,
      date: date,
      notes: notes,
      categoryId: categoryId,
    );
  }
}

/// @nodoc
const $ExpenseSupplements = _$ExpenseSupplementsTearOff();

/// @nodoc
mixin _$ExpenseSupplements {
  Map<String, String?> get errors => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpenseSupplementsCopyWith<ExpenseSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseSupplementsCopyWith<$Res> {
  factory $ExpenseSupplementsCopyWith(
          ExpenseSupplements value, $Res Function(ExpenseSupplements) then) =
      _$ExpenseSupplementsCopyWithImpl<$Res>;
  $Res call(
      {Map<String, String?> errors,
      String amount,
      DateTime date,
      String? notes,
      String categoryId});
}

/// @nodoc
class _$ExpenseSupplementsCopyWithImpl<$Res>
    implements $ExpenseSupplementsCopyWith<$Res> {
  _$ExpenseSupplementsCopyWithImpl(this._value, this._then);

  final ExpenseSupplements _value;
  // ignore: unused_field
  final $Res Function(ExpenseSupplements) _then;

  @override
  $Res call({
    Object? errors = freezed,
    Object? amount = freezed,
    Object? date = freezed,
    Object? notes = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_value.copyWith(
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ExpenseSupplementsCopyWith<$Res>
    implements $ExpenseSupplementsCopyWith<$Res> {
  factory _$ExpenseSupplementsCopyWith(
          _ExpenseSupplements value, $Res Function(_ExpenseSupplements) then) =
      __$ExpenseSupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, String?> errors,
      String amount,
      DateTime date,
      String? notes,
      String categoryId});
}

/// @nodoc
class __$ExpenseSupplementsCopyWithImpl<$Res>
    extends _$ExpenseSupplementsCopyWithImpl<$Res>
    implements _$ExpenseSupplementsCopyWith<$Res> {
  __$ExpenseSupplementsCopyWithImpl(
      _ExpenseSupplements _value, $Res Function(_ExpenseSupplements) _then)
      : super(_value, (v) => _then(v as _ExpenseSupplements));

  @override
  _ExpenseSupplements get _value => super._value as _ExpenseSupplements;

  @override
  $Res call({
    Object? errors = freezed,
    Object? amount = freezed,
    Object? date = freezed,
    Object? notes = freezed,
    Object? categoryId = freezed,
  }) {
    return _then(_ExpenseSupplements(
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ExpenseSupplements implements _ExpenseSupplements {
  const _$_ExpenseSupplements(
      {required this.errors,
      required this.amount,
      required this.date,
      this.notes,
      required this.categoryId});

  @override
  final Map<String, String?> errors;
  @override
  final String amount;
  @override
  final DateTime date;
  @override
  final String? notes;
  @override
  final String categoryId;

  @override
  String toString() {
    return 'ExpenseSupplements(errors: $errors, amount: $amount, date: $date, notes: $notes, categoryId: $categoryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpenseSupplements &&
            const DeepCollectionEquality().equals(other.errors, errors) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.notes, notes) &&
            const DeepCollectionEquality()
                .equals(other.categoryId, categoryId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(errors),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(notes),
      const DeepCollectionEquality().hash(categoryId));

  @JsonKey(ignore: true)
  @override
  _$ExpenseSupplementsCopyWith<_ExpenseSupplements> get copyWith =>
      __$ExpenseSupplementsCopyWithImpl<_ExpenseSupplements>(this, _$identity);
}

abstract class _ExpenseSupplements implements ExpenseSupplements {
  const factory _ExpenseSupplements(
      {required Map<String, String?> errors,
      required String amount,
      required DateTime date,
      String? notes,
      required String categoryId}) = _$_ExpenseSupplements;

  @override
  Map<String, String?> get errors;
  @override
  String get amount;
  @override
  DateTime get date;
  @override
  String? get notes;
  @override
  String get categoryId;
  @override
  @JsonKey(ignore: true)
  _$ExpenseSupplementsCopyWith<_ExpenseSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
