// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SearchPageStateTearOff {
  const _$SearchPageStateTearOff();

  _Loading<T> loading<T>(SearchPageSupplements<T> supplements) {
    return _Loading<T>(
      supplements,
    );
  }

  _Content<T> content<T>(SearchPageSupplements<T> supplements) {
    return _Content<T>(
      supplements,
    );
  }

  _Success<T> success<T>(SearchPageSupplements<T> supplements) {
    return _Success<T>(
      supplements,
    );
  }

  _Failed<T> failed<T>(SearchPageSupplements<T> supplements, String? message) {
    return _Failed<T>(
      supplements,
      message,
    );
  }
}

/// @nodoc
const $SearchPageState = _$SearchPageStateTearOff();

/// @nodoc
mixin _$SearchPageState<T> {
  SearchPageSupplements<T> get supplements =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SearchPageSupplements<T> supplements) loading,
    required TResult Function(SearchPageSupplements<T> supplements) content,
    required TResult Function(SearchPageSupplements<T> supplements) success,
    required TResult Function(
            SearchPageSupplements<T> supplements, String? message)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Content<T> value) content,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Failed<T> value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchPageStateCopyWith<T, SearchPageState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPageStateCopyWith<T, $Res> {
  factory $SearchPageStateCopyWith(
          SearchPageState<T> value, $Res Function(SearchPageState<T>) then) =
      _$SearchPageStateCopyWithImpl<T, $Res>;
  $Res call({SearchPageSupplements<T> supplements});

  $SearchPageSupplementsCopyWith<T, $Res> get supplements;
}

/// @nodoc
class _$SearchPageStateCopyWithImpl<T, $Res>
    implements $SearchPageStateCopyWith<T, $Res> {
  _$SearchPageStateCopyWithImpl(this._value, this._then);

  final SearchPageState<T> _value;
  // ignore: unused_field
  final $Res Function(SearchPageState<T>) _then;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as SearchPageSupplements<T>,
    ));
  }

  @override
  $SearchPageSupplementsCopyWith<T, $Res> get supplements {
    return $SearchPageSupplementsCopyWith<T, $Res>(_value.supplements, (value) {
      return _then(_value.copyWith(supplements: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<T, $Res>
    implements $SearchPageStateCopyWith<T, $Res> {
  factory _$LoadingCopyWith(
          _Loading<T> value, $Res Function(_Loading<T>) then) =
      __$LoadingCopyWithImpl<T, $Res>;
  @override
  $Res call({SearchPageSupplements<T> supplements});

  @override
  $SearchPageSupplementsCopyWith<T, $Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<T, $Res>
    extends _$SearchPageStateCopyWithImpl<T, $Res>
    implements _$LoadingCopyWith<T, $Res> {
  __$LoadingCopyWithImpl(_Loading<T> _value, $Res Function(_Loading<T>) _then)
      : super(_value, (v) => _then(v as _Loading<T>));

  @override
  _Loading<T> get _value => super._value as _Loading<T>;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Loading<T>(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as SearchPageSupplements<T>,
    ));
  }
}

/// @nodoc

class _$_Loading<T> implements _Loading<T> {
  const _$_Loading(this.supplements);

  @override
  final SearchPageSupplements<T> supplements;

  @override
  String toString() {
    return 'SearchPageState<$T>.loading(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading<T> &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<T, _Loading<T>> get copyWith =>
      __$LoadingCopyWithImpl<T, _Loading<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SearchPageSupplements<T> supplements) loading,
    required TResult Function(SearchPageSupplements<T> supplements) content,
    required TResult Function(SearchPageSupplements<T> supplements) success,
    required TResult Function(
            SearchPageSupplements<T> supplements, String? message)
        failed,
  }) {
    return loading(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
  }) {
    return loading?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
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
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Content<T> value) content,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Failed<T> value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<T> implements SearchPageState<T> {
  const factory _Loading(SearchPageSupplements<T> supplements) = _$_Loading<T>;

  @override
  SearchPageSupplements<T> get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<T, _Loading<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<T, $Res>
    implements $SearchPageStateCopyWith<T, $Res> {
  factory _$ContentCopyWith(
          _Content<T> value, $Res Function(_Content<T>) then) =
      __$ContentCopyWithImpl<T, $Res>;
  @override
  $Res call({SearchPageSupplements<T> supplements});

  @override
  $SearchPageSupplementsCopyWith<T, $Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<T, $Res>
    extends _$SearchPageStateCopyWithImpl<T, $Res>
    implements _$ContentCopyWith<T, $Res> {
  __$ContentCopyWithImpl(_Content<T> _value, $Res Function(_Content<T>) _then)
      : super(_value, (v) => _then(v as _Content<T>));

  @override
  _Content<T> get _value => super._value as _Content<T>;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Content<T>(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as SearchPageSupplements<T>,
    ));
  }
}

/// @nodoc

class _$_Content<T> implements _Content<T> {
  const _$_Content(this.supplements);

  @override
  final SearchPageSupplements<T> supplements;

  @override
  String toString() {
    return 'SearchPageState<$T>.content(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content<T> &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<T, _Content<T>> get copyWith =>
      __$ContentCopyWithImpl<T, _Content<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SearchPageSupplements<T> supplements) loading,
    required TResult Function(SearchPageSupplements<T> supplements) content,
    required TResult Function(SearchPageSupplements<T> supplements) success,
    required TResult Function(
            SearchPageSupplements<T> supplements, String? message)
        failed,
  }) {
    return content(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
  }) {
    return content?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
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
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Content<T> value) content,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Failed<T> value) failed,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content<T> implements SearchPageState<T> {
  const factory _Content(SearchPageSupplements<T> supplements) = _$_Content<T>;

  @override
  SearchPageSupplements<T> get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<T, _Content<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SuccessCopyWith<T, $Res>
    implements $SearchPageStateCopyWith<T, $Res> {
  factory _$SuccessCopyWith(
          _Success<T> value, $Res Function(_Success<T>) then) =
      __$SuccessCopyWithImpl<T, $Res>;
  @override
  $Res call({SearchPageSupplements<T> supplements});

  @override
  $SearchPageSupplementsCopyWith<T, $Res> get supplements;
}

/// @nodoc
class __$SuccessCopyWithImpl<T, $Res>
    extends _$SearchPageStateCopyWithImpl<T, $Res>
    implements _$SuccessCopyWith<T, $Res> {
  __$SuccessCopyWithImpl(_Success<T> _value, $Res Function(_Success<T>) _then)
      : super(_value, (v) => _then(v as _Success<T>));

  @override
  _Success<T> get _value => super._value as _Success<T>;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_Success<T>(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as SearchPageSupplements<T>,
    ));
  }
}

/// @nodoc

class _$_Success<T> implements _Success<T> {
  const _$_Success(this.supplements);

  @override
  final SearchPageSupplements<T> supplements;

  @override
  String toString() {
    return 'SearchPageState<$T>.success(supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success<T> &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(supplements));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<T, _Success<T>> get copyWith =>
      __$SuccessCopyWithImpl<T, _Success<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SearchPageSupplements<T> supplements) loading,
    required TResult Function(SearchPageSupplements<T> supplements) content,
    required TResult Function(SearchPageSupplements<T> supplements) success,
    required TResult Function(
            SearchPageSupplements<T> supplements, String? message)
        failed,
  }) {
    return success(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
  }) {
    return success?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
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
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Content<T> value) content,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Failed<T> value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<T> implements SearchPageState<T> {
  const factory _Success(SearchPageSupplements<T> supplements) = _$_Success<T>;

  @override
  SearchPageSupplements<T> get supplements;
  @override
  @JsonKey(ignore: true)
  _$SuccessCopyWith<T, _Success<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<T, $Res>
    implements $SearchPageStateCopyWith<T, $Res> {
  factory _$FailedCopyWith(_Failed<T> value, $Res Function(_Failed<T>) then) =
      __$FailedCopyWithImpl<T, $Res>;
  @override
  $Res call({SearchPageSupplements<T> supplements, String? message});

  @override
  $SearchPageSupplementsCopyWith<T, $Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<T, $Res>
    extends _$SearchPageStateCopyWithImpl<T, $Res>
    implements _$FailedCopyWith<T, $Res> {
  __$FailedCopyWithImpl(_Failed<T> _value, $Res Function(_Failed<T>) _then)
      : super(_value, (v) => _then(v as _Failed<T>));

  @override
  _Failed<T> get _value => super._value as _Failed<T>;

  @override
  $Res call({
    Object? supplements = freezed,
    Object? message = freezed,
  }) {
    return _then(_Failed<T>(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as SearchPageSupplements<T>,
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Failed<T> implements _Failed<T> {
  const _$_Failed(this.supplements, this.message);

  @override
  final SearchPageSupplements<T> supplements;
  @override
  final String? message;

  @override
  String toString() {
    return 'SearchPageState<$T>.failed(supplements: $supplements, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed<T> &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supplements),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<T, _Failed<T>> get copyWith =>
      __$FailedCopyWithImpl<T, _Failed<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SearchPageSupplements<T> supplements) loading,
    required TResult Function(SearchPageSupplements<T> supplements) content,
    required TResult Function(SearchPageSupplements<T> supplements) success,
    required TResult Function(
            SearchPageSupplements<T> supplements, String? message)
        failed,
  }) {
    return failed(supplements, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
  }) {
    return failed?.call(supplements, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SearchPageSupplements<T> supplements)? loading,
    TResult Function(SearchPageSupplements<T> supplements)? content,
    TResult Function(SearchPageSupplements<T> supplements)? success,
    TResult Function(SearchPageSupplements<T> supplements, String? message)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(supplements, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Content<T> value) content,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Failed<T> value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Content<T> value)? content,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Failed<T> value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed<T> implements SearchPageState<T> {
  const factory _Failed(SearchPageSupplements<T> supplements, String? message) =
      _$_Failed<T>;

  @override
  SearchPageSupplements<T> get supplements;
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<T, _Failed<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
