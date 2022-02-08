// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'records_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecordsSupplementsTearOff {
  const _$RecordsSupplementsTearOff();

  _RecordsSupplements call(
      {required List<Record> recordList, required List<Item> itemList}) {
    return _RecordsSupplements(
      recordList: recordList,
      itemList: itemList,
    );
  }
}

/// @nodoc
const $RecordsSupplements = _$RecordsSupplementsTearOff();

/// @nodoc
mixin _$RecordsSupplements {
  List<Record> get recordList => throw _privateConstructorUsedError;
  List<Item> get itemList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordsSupplementsCopyWith<RecordsSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsSupplementsCopyWith<$Res> {
  factory $RecordsSupplementsCopyWith(
          RecordsSupplements value, $Res Function(RecordsSupplements) then) =
      _$RecordsSupplementsCopyWithImpl<$Res>;
  $Res call({List<Record> recordList, List<Item> itemList});
}

/// @nodoc
class _$RecordsSupplementsCopyWithImpl<$Res>
    implements $RecordsSupplementsCopyWith<$Res> {
  _$RecordsSupplementsCopyWithImpl(this._value, this._then);

  final RecordsSupplements _value;
  // ignore: unused_field
  final $Res Function(RecordsSupplements) _then;

  @override
  $Res call({
    Object? recordList = freezed,
    Object? itemList = freezed,
  }) {
    return _then(_value.copyWith(
      recordList: recordList == freezed
          ? _value.recordList
          : recordList // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      itemList: itemList == freezed
          ? _value.itemList
          : itemList // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc
abstract class _$RecordsSupplementsCopyWith<$Res>
    implements $RecordsSupplementsCopyWith<$Res> {
  factory _$RecordsSupplementsCopyWith(
          _RecordsSupplements value, $Res Function(_RecordsSupplements) then) =
      __$RecordsSupplementsCopyWithImpl<$Res>;
  @override
  $Res call({List<Record> recordList, List<Item> itemList});
}

/// @nodoc
class __$RecordsSupplementsCopyWithImpl<$Res>
    extends _$RecordsSupplementsCopyWithImpl<$Res>
    implements _$RecordsSupplementsCopyWith<$Res> {
  __$RecordsSupplementsCopyWithImpl(
      _RecordsSupplements _value, $Res Function(_RecordsSupplements) _then)
      : super(_value, (v) => _then(v as _RecordsSupplements));

  @override
  _RecordsSupplements get _value => super._value as _RecordsSupplements;

  @override
  $Res call({
    Object? recordList = freezed,
    Object? itemList = freezed,
  }) {
    return _then(_RecordsSupplements(
      recordList: recordList == freezed
          ? _value.recordList
          : recordList // ignore: cast_nullable_to_non_nullable
              as List<Record>,
      itemList: itemList == freezed
          ? _value.itemList
          : itemList // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc

class _$_RecordsSupplements implements _RecordsSupplements {
  const _$_RecordsSupplements(
      {required this.recordList, required this.itemList});

  @override
  final List<Record> recordList;
  @override
  final List<Item> itemList;

  @override
  String toString() {
    return 'RecordsSupplements(recordList: $recordList, itemList: $itemList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordsSupplements &&
            const DeepCollectionEquality()
                .equals(other.recordList, recordList) &&
            const DeepCollectionEquality().equals(other.itemList, itemList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recordList),
      const DeepCollectionEquality().hash(itemList));

  @JsonKey(ignore: true)
  @override
  _$RecordsSupplementsCopyWith<_RecordsSupplements> get copyWith =>
      __$RecordsSupplementsCopyWithImpl<_RecordsSupplements>(this, _$identity);
}

abstract class _RecordsSupplements implements RecordsSupplements {
  const factory _RecordsSupplements(
      {required List<Record> recordList,
      required List<Item> itemList}) = _$_RecordsSupplements;

  @override
  List<Record> get recordList;
  @override
  List<Item> get itemList;
  @override
  @JsonKey(ignore: true)
  _$RecordsSupplementsCopyWith<_RecordsSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
