// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../search_page_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SearchPageSupplementsTearOff {
  const _$SearchPageSupplementsTearOff();

  _SearchPageSupplements<T> call<T>(
      {required String query, required List<T> options}) {
    return _SearchPageSupplements<T>(
      query: query,
      options: options,
    );
  }
}

/// @nodoc
const $SearchPageSupplements = _$SearchPageSupplementsTearOff();

/// @nodoc
mixin _$SearchPageSupplements<T> {
  String get query => throw _privateConstructorUsedError;
  List<T> get options => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchPageSupplementsCopyWith<T, SearchPageSupplements<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPageSupplementsCopyWith<T, $Res> {
  factory $SearchPageSupplementsCopyWith(SearchPageSupplements<T> value,
          $Res Function(SearchPageSupplements<T>) then) =
      _$SearchPageSupplementsCopyWithImpl<T, $Res>;
  $Res call({String query, List<T> options});
}

/// @nodoc
class _$SearchPageSupplementsCopyWithImpl<T, $Res>
    implements $SearchPageSupplementsCopyWith<T, $Res> {
  _$SearchPageSupplementsCopyWithImpl(this._value, this._then);

  final SearchPageSupplements<T> _value;
  // ignore: unused_field
  final $Res Function(SearchPageSupplements<T>) _then;

  @override
  $Res call({
    Object? query = freezed,
    Object? options = freezed,
  }) {
    return _then(_value.copyWith(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      options: options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
abstract class _$SearchPageSupplementsCopyWith<T, $Res>
    implements $SearchPageSupplementsCopyWith<T, $Res> {
  factory _$SearchPageSupplementsCopyWith(_SearchPageSupplements<T> value,
          $Res Function(_SearchPageSupplements<T>) then) =
      __$SearchPageSupplementsCopyWithImpl<T, $Res>;
  @override
  $Res call({String query, List<T> options});
}

/// @nodoc
class __$SearchPageSupplementsCopyWithImpl<T, $Res>
    extends _$SearchPageSupplementsCopyWithImpl<T, $Res>
    implements _$SearchPageSupplementsCopyWith<T, $Res> {
  __$SearchPageSupplementsCopyWithImpl(_SearchPageSupplements<T> _value,
      $Res Function(_SearchPageSupplements<T>) _then)
      : super(_value, (v) => _then(v as _SearchPageSupplements<T>));

  @override
  _SearchPageSupplements<T> get _value =>
      super._value as _SearchPageSupplements<T>;

  @override
  $Res call({
    Object? query = freezed,
    Object? options = freezed,
  }) {
    return _then(_SearchPageSupplements<T>(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      options: options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$_SearchPageSupplements<T> implements _SearchPageSupplements<T> {
  const _$_SearchPageSupplements({required this.query, required this.options});

  @override
  final String query;
  @override
  final List<T> options;

  @override
  String toString() {
    return 'SearchPageSupplements<$T>(query: $query, options: $options)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchPageSupplements<T> &&
            const DeepCollectionEquality().equals(other.query, query) &&
            const DeepCollectionEquality().equals(other.options, options));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(query),
      const DeepCollectionEquality().hash(options));

  @JsonKey(ignore: true)
  @override
  _$SearchPageSupplementsCopyWith<T, _SearchPageSupplements<T>> get copyWith =>
      __$SearchPageSupplementsCopyWithImpl<T, _SearchPageSupplements<T>>(
          this, _$identity);
}

abstract class _SearchPageSupplements<T> implements SearchPageSupplements<T> {
  const factory _SearchPageSupplements(
      {required String query,
      required List<T> options}) = _$_SearchPageSupplements<T>;

  @override
  String get query;
  @override
  List<T> get options;
  @override
  @JsonKey(ignore: true)
  _$SearchPageSupplementsCopyWith<T, _SearchPageSupplements<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
