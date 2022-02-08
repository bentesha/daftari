// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'item_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ItemPageStateTearOff {
  const _$ItemPageStateTearOff();

  _Loading loading(ItemSupplements supp) {
    return _Loading(
      supp,
    );
  }

  _Content content(ItemSupplements supp) {
    return _Content(
      supp,
    );
  }

  _Success success(ItemSupplements supp) {
    return _Success(
      supp,
    );
  }
}

/// @nodoc
const $ItemPageState = _$ItemPageStateTearOff();

/// @nodoc
mixin _$ItemPageState {
  ItemSupplements get supp => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ItemSupplements supp) loading,
    required TResult Function(ItemSupplements supp) content,
    required TResult Function(ItemSupplements supp) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemPageStateCopyWith<ItemPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemPageStateCopyWith<$Res> {
  factory $ItemPageStateCopyWith(
          ItemPageState value, $Res Function(ItemPageState) then) =
      _$ItemPageStateCopyWithImpl<$Res>;
  $Res call({ItemSupplements supp});

  $ItemSupplementsCopyWith<$Res> get supp;
}

/// @nodoc
class _$ItemPageStateCopyWithImpl<$Res>
    implements $ItemPageStateCopyWith<$Res> {
  _$ItemPageStateCopyWithImpl(this._value, this._then);

  final ItemPageState _value;
  // ignore: unused_field
  final $Res Function(ItemPageState) _then;

  @override
  $Res call({
    Object? supp = freezed,
  }) {
    return _then(_value.copyWith(
      supp: supp == freezed
          ? _value.supp
          : supp // ignore: cast_nullable_to_non_nullable
              as ItemSupplements,
    ));
  }

  @override
  $ItemSupplementsCopyWith<$Res> get supp {
    return $ItemSupplementsCopyWith<$Res>(_value.supp, (value) {
      return _then(_value.copyWith(supp: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> implements $ItemPageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({ItemSupplements supp});

  @override
  $ItemSupplementsCopyWith<$Res> get supp;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$ItemPageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? supp = freezed,
  }) {
    return _then(_Loading(
      supp == freezed
          ? _value.supp
          : supp // ignore: cast_nullable_to_non_nullable
              as ItemSupplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.supp);

  @override
  final ItemSupplements supp;

  @override
  String toString() {
    return 'ItemPageState.loading(supp: $supp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality().equals(other.supp, supp));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(supp));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ItemSupplements supp) loading,
    required TResult Function(ItemSupplements supp) content,
    required TResult Function(ItemSupplements supp) success,
  }) {
    return loading(supp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
  }) {
    return loading?.call(supp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(supp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ItemPageState {
  const factory _Loading(ItemSupplements supp) = _$_Loading;

  @override
  ItemSupplements get supp;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res> implements $ItemPageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({ItemSupplements supp});

  @override
  $ItemSupplementsCopyWith<$Res> get supp;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$ItemPageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? supp = freezed,
  }) {
    return _then(_Content(
      supp == freezed
          ? _value.supp
          : supp // ignore: cast_nullable_to_non_nullable
              as ItemSupplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.supp);

  @override
  final ItemSupplements supp;

  @override
  String toString() {
    return 'ItemPageState.content(supp: $supp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality().equals(other.supp, supp));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(supp));

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ItemSupplements supp) loading,
    required TResult Function(ItemSupplements supp) content,
    required TResult Function(ItemSupplements supp) success,
  }) {
    return content(supp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
  }) {
    return content?.call(supp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(supp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements ItemPageState {
  const factory _Content(ItemSupplements supp) = _$_Content;

  @override
  ItemSupplements get supp;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res> implements $ItemPageStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  @override
  $Res call({ItemSupplements supp});

  @override
  $ItemSupplementsCopyWith<$Res> get supp;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> extends _$ItemPageStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object? supp = freezed,
  }) {
    return _then(_Success(
      supp == freezed
          ? _value.supp
          : supp // ignore: cast_nullable_to_non_nullable
              as ItemSupplements,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(this.supp);

  @override
  final ItemSupplements supp;

  @override
  String toString() {
    return 'ItemPageState.success(supp: $supp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            const DeepCollectionEquality().equals(other.supp, supp));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(supp));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ItemSupplements supp) loading,
    required TResult Function(ItemSupplements supp) content,
    required TResult Function(ItemSupplements supp) success,
  }) {
    return success(supp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
  }) {
    return success?.call(supp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ItemSupplements supp)? loading,
    TResult Function(ItemSupplements supp)? content,
    TResult Function(ItemSupplements supp)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(supp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ItemPageState {
  const factory _Success(ItemSupplements supp) = _$_Success;

  @override
  ItemSupplements get supp;
  @override
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith =>
      throw _privateConstructorUsedError;
}
