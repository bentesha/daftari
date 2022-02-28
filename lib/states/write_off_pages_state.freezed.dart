// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'write_off_pages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WriteOffPagesStateTearOff {
  const _$WriteOffPagesStateTearOff();

  _Loading loading(WriteOffSupplements supplements) {
    return _Loading(
      supplements,
    );
  }

  _Content content(WriteOffSupplements supplements) {
    return _Content(
      supplements,
    );
  }

  _Success success(WriteOffSupplements supplements) {
    return _Success(
      supplements,
    );
  }
}

/// @nodoc
const $WriteOffPagesState = _$WriteOffPagesStateTearOff();

/// @nodoc
mixin _$WriteOffPagesState {
  WriteOffSupplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WriteOffSupplements supplements) loading,
    required TResult Function(WriteOffSupplements supplements) content,
    required TResult Function(WriteOffSupplements supplements) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
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
  $WriteOffPagesStateCopyWith<WriteOffPagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WriteOffPagesStateCopyWith<$Res> {
  factory $WriteOffPagesStateCopyWith(
          WriteOffPagesState value, $Res Function(WriteOffPagesState) then) =
      _$WriteOffPagesStateCopyWithImpl<$Res>;
  $Res call({WriteOffSupplements supplements});

  $WriteOffSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$WriteOffPagesStateCopyWithImpl<$Res>
    implements $WriteOffPagesStateCopyWith<$Res> {
  _$WriteOffPagesStateCopyWithImpl(this._value, this._then);

  final WriteOffPagesState _value;
  // ignore: unused_field
  final $Res Function(WriteOffPagesState) _then;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as WriteOffSupplements,
    ));
  }

  @override
  $WriteOffSupplementsCopyWith<$Res> get supplements {
    return $WriteOffSupplementsCopyWith<$Res>(_value.supplements, (value) {
      return _then(_value.copyWith(supplements: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $WriteOffPagesStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({WriteOffSupplements supplements});

  @override
  $WriteOffSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$WriteOffPagesStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as WriteOffSupplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.supplements);

  @override
  final WriteOffSupplements supplements;

  @override
  String toString() {
    return 'WriteOffPagesState.loading(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WriteOffSupplements supplements) loading,
    required TResult Function(WriteOffSupplements supplements) content,
    required TResult Function(WriteOffSupplements supplements) success,
  }) {
    return loading(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
  }) {
    return loading?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(supplements);
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

abstract class _Loading implements WriteOffPagesState {
  const factory _Loading(WriteOffSupplements supplements) = _$_Loading;

  @override
  WriteOffSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $WriteOffPagesStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({WriteOffSupplements supplements});

  @override
  $WriteOffSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res>
    extends _$WriteOffPagesStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as WriteOffSupplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.supplements);

  @override
  final WriteOffSupplements supplements;

  @override
  String toString() {
    return 'WriteOffPagesState.content(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WriteOffSupplements supplements) loading,
    required TResult Function(WriteOffSupplements supplements) content,
    required TResult Function(WriteOffSupplements supplements) success,
  }) {
    return content(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
  }) {
    return content?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(supplements);
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

abstract class _Content implements WriteOffPagesState {
  const factory _Content(WriteOffSupplements supplements) = _$_Content;

  @override
  WriteOffSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res>
    implements $WriteOffPagesStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  @override
  $Res call({WriteOffSupplements supplements});

  @override
  $WriteOffSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    extends _$WriteOffPagesStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Success(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as WriteOffSupplements,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(this.supplements);

  @override
  final WriteOffSupplements supplements;

  @override
  String toString() {
    return 'WriteOffPagesState.success(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(WriteOffSupplements supplements) loading,
    required TResult Function(WriteOffSupplements supplements) content,
    required TResult Function(WriteOffSupplements supplements) success,
  }) {
    return success(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
  }) {
    return success?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(WriteOffSupplements supplements)? loading,
    TResult Function(WriteOffSupplements supplements)? content,
    TResult Function(WriteOffSupplements supplements)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(supplements);
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

abstract class _Success implements WriteOffPagesState {
  const factory _Success(WriteOffSupplements supplements) = _$_Success;

  @override
  WriteOffSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith =>
      throw _privateConstructorUsedError;
}
