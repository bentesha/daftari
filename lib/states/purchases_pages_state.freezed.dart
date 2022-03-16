// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'purchases_pages_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PurchasesPagesStateTearOff {
  const _$PurchasesPagesStateTearOff();

  _Loading loading(PurchasesPagesSupplements supplements) {
    return _Loading(
      supplements,
    );
  }

  _Content content(PurchasesPagesSupplements supplements) {
    return _Content(
      supplements,
    );
  }

  _Success success(PurchasesPagesSupplements supplements) {
    return _Success(
      supplements,
    );
  }

  _Failed failed(PurchasesPagesSupplements supplements,
      {String? message, bool showOnPage = false}) {
    return _Failed(
      supplements,
      message: message,
      showOnPage: showOnPage,
    );
  }
}

/// @nodoc
const $PurchasesPagesState = _$PurchasesPagesStateTearOff();

/// @nodoc
mixin _$PurchasesPagesState {
  PurchasesPagesSupplements get supplements =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PurchasesPagesSupplements supplements) loading,
    required TResult Function(PurchasesPagesSupplements supplements) content,
    required TResult Function(PurchasesPagesSupplements supplements) success,
    required TResult Function(PurchasesPagesSupplements supplements,
            String? message, bool showOnPage)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PurchasesPagesStateCopyWith<PurchasesPagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasesPagesStateCopyWith<$Res> {
  factory $PurchasesPagesStateCopyWith(
          PurchasesPagesState value, $Res Function(PurchasesPagesState) then) =
      _$PurchasesPagesStateCopyWithImpl<$Res>;
  $Res call({PurchasesPagesSupplements supplements});

  $PurchasesPagesSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$PurchasesPagesStateCopyWithImpl<$Res>
    implements $PurchasesPagesStateCopyWith<$Res> {
  _$PurchasesPagesStateCopyWithImpl(this._value, this._then);

  final PurchasesPagesState _value;
  // ignore: unused_field
  final $Res Function(PurchasesPagesState) _then;

  @override
  $Res call({
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as PurchasesPagesSupplements,
    ));
  }

  @override
  $PurchasesPagesSupplementsCopyWith<$Res> get supplements {
    return $PurchasesPagesSupplementsCopyWith<$Res>(_value.supplements,
        (value) {
      return _then(_value.copyWith(supplements: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $PurchasesPagesStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({PurchasesPagesSupplements supplements});

  @override
  $PurchasesPagesSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$PurchasesPagesStateCopyWithImpl<$Res>
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
              as PurchasesPagesSupplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.supplements);

  @override
  final PurchasesPagesSupplements supplements;

  @override
  String toString() {
    return 'PurchasesPagesState.loading(supplements: $supplements)';
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
    required TResult Function(PurchasesPagesSupplements supplements) loading,
    required TResult Function(PurchasesPagesSupplements supplements) content,
    required TResult Function(PurchasesPagesSupplements supplements) success,
    required TResult Function(PurchasesPagesSupplements supplements,
            String? message, bool showOnPage)
        failed,
  }) {
    return loading(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
  }) {
    return loading?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PurchasesPagesState {
  const factory _Loading(PurchasesPagesSupplements supplements) = _$_Loading;

  @override
  PurchasesPagesSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $PurchasesPagesStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({PurchasesPagesSupplements supplements});

  @override
  $PurchasesPagesSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res>
    extends _$PurchasesPagesStateCopyWithImpl<$Res>
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
              as PurchasesPagesSupplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.supplements);

  @override
  final PurchasesPagesSupplements supplements;

  @override
  String toString() {
    return 'PurchasesPagesState.content(supplements: $supplements)';
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
    required TResult Function(PurchasesPagesSupplements supplements) loading,
    required TResult Function(PurchasesPagesSupplements supplements) content,
    required TResult Function(PurchasesPagesSupplements supplements) success,
    required TResult Function(PurchasesPagesSupplements supplements,
            String? message, bool showOnPage)
        failed,
  }) {
    return content(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
  }) {
    return content?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements PurchasesPagesState {
  const factory _Content(PurchasesPagesSupplements supplements) = _$_Content;

  @override
  PurchasesPagesSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res>
    implements $PurchasesPagesStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  @override
  $Res call({PurchasesPagesSupplements supplements});

  @override
  $PurchasesPagesSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    extends _$PurchasesPagesStateCopyWithImpl<$Res>
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
              as PurchasesPagesSupplements,
    ));
  }
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success(this.supplements);

  @override
  final PurchasesPagesSupplements supplements;

  @override
  String toString() {
    return 'PurchasesPagesState.success(supplements: $supplements)';
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
    required TResult Function(PurchasesPagesSupplements supplements) loading,
    required TResult Function(PurchasesPagesSupplements supplements) content,
    required TResult Function(PurchasesPagesSupplements supplements) success,
    required TResult Function(PurchasesPagesSupplements supplements,
            String? message, bool showOnPage)
        failed,
  }) {
    return success(supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
  }) {
    return success?.call(supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements PurchasesPagesState {
  const factory _Success(PurchasesPagesSupplements supplements) = _$_Success;

  @override
  PurchasesPagesSupplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$SuccessCopyWith<_Success> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $PurchasesPagesStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call(
      {PurchasesPagesSupplements supplements,
      String? message,
      bool showOnPage});

  @override
  $PurchasesPagesSupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res>
    extends _$PurchasesPagesStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? supplements = freezed,
    Object? message = freezed,
    Object? showOnPage = freezed,
  }) {
    return _then(_Failed(
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as PurchasesPagesSupplements,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      showOnPage: showOnPage == freezed
          ? _value.showOnPage
          : showOnPage // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.supplements, {this.message, this.showOnPage = false});

  @override
  final PurchasesPagesSupplements supplements;
  @override
  final String? message;
  @JsonKey()
  @override
  final bool showOnPage;

  @override
  String toString() {
    return 'PurchasesPagesState.failed(supplements: $supplements, message: $message, showOnPage: $showOnPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            const DeepCollectionEquality()
                .equals(other.supplements, supplements) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.showOnPage, showOnPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supplements),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(showOnPage));

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PurchasesPagesSupplements supplements) loading,
    required TResult Function(PurchasesPagesSupplements supplements) content,
    required TResult Function(PurchasesPagesSupplements supplements) success,
    required TResult Function(PurchasesPagesSupplements supplements,
            String? message, bool showOnPage)
        failed,
  }) {
    return failed(supplements, message, showOnPage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
  }) {
    return failed?.call(supplements, message, showOnPage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PurchasesPagesSupplements supplements)? loading,
    TResult Function(PurchasesPagesSupplements supplements)? content,
    TResult Function(PurchasesPagesSupplements supplements)? success,
    TResult Function(PurchasesPagesSupplements supplements, String? message,
            bool showOnPage)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(supplements, message, showOnPage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Success value) success,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Success value)? success,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements PurchasesPagesState {
  const factory _Failed(PurchasesPagesSupplements supplements,
      {String? message, bool showOnPage}) = _$_Failed;

  @override
  PurchasesPagesSupplements get supplements;
  String? get message;
  bool get showOnPage;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}
