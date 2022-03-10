// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DocumentTearOff {
  const _$DocumentTearOff();

  _Sales sales(DocumentForm form, List<Sales> sales) {
    return _Sales(
      form,
      sales,
    );
  }

  _Purchases purchases(DocumentForm form) {
    return _Purchases(
      form,
    );
  }

  _Expenses expenses(DocumentForm form) {
    return _Expenses(
      form,
    );
  }

  _WriteOffs writeOffs(DocumentForm form) {
    return _WriteOffs(
      form,
    );
  }
}

/// @nodoc
const $Document = _$DocumentTearOff();

/// @nodoc
mixin _$Document {
  DocumentForm get form => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> sales) sales,
    required TResult Function(DocumentForm form) purchases,
    required TResult Function(DocumentForm form) expenses,
    required TResult Function(DocumentForm form) writeOffs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Sales value) sales,
    required TResult Function(_Purchases value) purchases,
    required TResult Function(_Expenses value) expenses,
    required TResult Function(_WriteOffs value) writeOffs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res>;
  $Res call({DocumentForm form});

  $DocumentFormCopyWith<$Res> get form;
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res> implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  final Document _value;
  // ignore: unused_field
  final $Res Function(Document) _then;

  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_value.copyWith(
      form: form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
    ));
  }

  @override
  $DocumentFormCopyWith<$Res> get form {
    return $DocumentFormCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value));
    });
  }
}

/// @nodoc
abstract class _$SalesCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$SalesCopyWith(_Sales value, $Res Function(_Sales) then) =
      __$SalesCopyWithImpl<$Res>;
  @override
  $Res call({DocumentForm form, List<Sales> sales});

  @override
  $DocumentFormCopyWith<$Res> get form;
}

/// @nodoc
class __$SalesCopyWithImpl<$Res> extends _$DocumentCopyWithImpl<$Res>
    implements _$SalesCopyWith<$Res> {
  __$SalesCopyWithImpl(_Sales _value, $Res Function(_Sales) _then)
      : super(_value, (v) => _then(v as _Sales));

  @override
  _Sales get _value => super._value as _Sales;

  @override
  $Res call({
    Object? form = freezed,
    Object? sales = freezed,
  }) {
    return _then(_Sales(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
      sales == freezed
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sales>,
    ));
  }
}

/// @nodoc

class _$_Sales extends _Sales {
  const _$_Sales(this.form, this.sales) : super._();

  @override
  final DocumentForm form;
  @override
  final List<Sales> sales;

  @override
  String toString() {
    return 'Document.sales(form: $form, sales: $sales)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Sales &&
            const DeepCollectionEquality().equals(other.form, form) &&
            const DeepCollectionEquality().equals(other.sales, sales));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(form),
      const DeepCollectionEquality().hash(sales));

  @JsonKey(ignore: true)
  @override
  _$SalesCopyWith<_Sales> get copyWith =>
      __$SalesCopyWithImpl<_Sales>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> sales) sales,
    required TResult Function(DocumentForm form) purchases,
    required TResult Function(DocumentForm form) expenses,
    required TResult Function(DocumentForm form) writeOffs,
  }) {
    return sales(form, this.sales);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
  }) {
    return sales?.call(form, this.sales);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
    required TResult orElse(),
  }) {
    if (sales != null) {
      return sales(form, this.sales);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Sales value) sales,
    required TResult Function(_Purchases value) purchases,
    required TResult Function(_Expenses value) expenses,
    required TResult Function(_WriteOffs value) writeOffs,
  }) {
    return sales(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
  }) {
    return sales?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
    required TResult orElse(),
  }) {
    if (sales != null) {
      return sales(this);
    }
    return orElse();
  }
}

abstract class _Sales extends Document {
  const factory _Sales(DocumentForm form, List<Sales> sales) = _$_Sales;
  const _Sales._() : super._();

  @override
  DocumentForm get form;
  List<Sales> get sales;
  @override
  @JsonKey(ignore: true)
  _$SalesCopyWith<_Sales> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PurchasesCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$PurchasesCopyWith(
          _Purchases value, $Res Function(_Purchases) then) =
      __$PurchasesCopyWithImpl<$Res>;
  @override
  $Res call({DocumentForm form});

  @override
  $DocumentFormCopyWith<$Res> get form;
}

/// @nodoc
class __$PurchasesCopyWithImpl<$Res> extends _$DocumentCopyWithImpl<$Res>
    implements _$PurchasesCopyWith<$Res> {
  __$PurchasesCopyWithImpl(_Purchases _value, $Res Function(_Purchases) _then)
      : super(_value, (v) => _then(v as _Purchases));

  @override
  _Purchases get _value => super._value as _Purchases;

  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_Purchases(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
    ));
  }
}

/// @nodoc

class _$_Purchases extends _Purchases {
  const _$_Purchases(this.form) : super._();

  @override
  final DocumentForm form;

  @override
  String toString() {
    return 'Document.purchases(form: $form)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Purchases &&
            const DeepCollectionEquality().equals(other.form, form));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(form));

  @JsonKey(ignore: true)
  @override
  _$PurchasesCopyWith<_Purchases> get copyWith =>
      __$PurchasesCopyWithImpl<_Purchases>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> sales) sales,
    required TResult Function(DocumentForm form) purchases,
    required TResult Function(DocumentForm form) expenses,
    required TResult Function(DocumentForm form) writeOffs,
  }) {
    return purchases(form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
  }) {
    return purchases?.call(form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
    required TResult orElse(),
  }) {
    if (purchases != null) {
      return purchases(form);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Sales value) sales,
    required TResult Function(_Purchases value) purchases,
    required TResult Function(_Expenses value) expenses,
    required TResult Function(_WriteOffs value) writeOffs,
  }) {
    return purchases(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
  }) {
    return purchases?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
    required TResult orElse(),
  }) {
    if (purchases != null) {
      return purchases(this);
    }
    return orElse();
  }
}

abstract class _Purchases extends Document {
  const factory _Purchases(DocumentForm form) = _$_Purchases;
  const _Purchases._() : super._();

  @override
  DocumentForm get form;
  @override
  @JsonKey(ignore: true)
  _$PurchasesCopyWith<_Purchases> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ExpensesCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$ExpensesCopyWith(_Expenses value, $Res Function(_Expenses) then) =
      __$ExpensesCopyWithImpl<$Res>;
  @override
  $Res call({DocumentForm form});

  @override
  $DocumentFormCopyWith<$Res> get form;
}

/// @nodoc
class __$ExpensesCopyWithImpl<$Res> extends _$DocumentCopyWithImpl<$Res>
    implements _$ExpensesCopyWith<$Res> {
  __$ExpensesCopyWithImpl(_Expenses _value, $Res Function(_Expenses) _then)
      : super(_value, (v) => _then(v as _Expenses));

  @override
  _Expenses get _value => super._value as _Expenses;

  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_Expenses(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
    ));
  }
}

/// @nodoc

class _$_Expenses extends _Expenses {
  const _$_Expenses(this.form) : super._();

  @override
  final DocumentForm form;

  @override
  String toString() {
    return 'Document.expenses(form: $form)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Expenses &&
            const DeepCollectionEquality().equals(other.form, form));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(form));

  @JsonKey(ignore: true)
  @override
  _$ExpensesCopyWith<_Expenses> get copyWith =>
      __$ExpensesCopyWithImpl<_Expenses>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> sales) sales,
    required TResult Function(DocumentForm form) purchases,
    required TResult Function(DocumentForm form) expenses,
    required TResult Function(DocumentForm form) writeOffs,
  }) {
    return expenses(form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
  }) {
    return expenses?.call(form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
    required TResult orElse(),
  }) {
    if (expenses != null) {
      return expenses(form);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Sales value) sales,
    required TResult Function(_Purchases value) purchases,
    required TResult Function(_Expenses value) expenses,
    required TResult Function(_WriteOffs value) writeOffs,
  }) {
    return expenses(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
  }) {
    return expenses?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
    required TResult orElse(),
  }) {
    if (expenses != null) {
      return expenses(this);
    }
    return orElse();
  }
}

abstract class _Expenses extends Document {
  const factory _Expenses(DocumentForm form) = _$_Expenses;
  const _Expenses._() : super._();

  @override
  DocumentForm get form;
  @override
  @JsonKey(ignore: true)
  _$ExpensesCopyWith<_Expenses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$WriteOffsCopyWith<$Res> implements $DocumentCopyWith<$Res> {
  factory _$WriteOffsCopyWith(
          _WriteOffs value, $Res Function(_WriteOffs) then) =
      __$WriteOffsCopyWithImpl<$Res>;
  @override
  $Res call({DocumentForm form});

  @override
  $DocumentFormCopyWith<$Res> get form;
}

/// @nodoc
class __$WriteOffsCopyWithImpl<$Res> extends _$DocumentCopyWithImpl<$Res>
    implements _$WriteOffsCopyWith<$Res> {
  __$WriteOffsCopyWithImpl(_WriteOffs _value, $Res Function(_WriteOffs) _then)
      : super(_value, (v) => _then(v as _WriteOffs));

  @override
  _WriteOffs get _value => super._value as _WriteOffs;

  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_WriteOffs(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
    ));
  }
}

/// @nodoc

class _$_WriteOffs extends _WriteOffs {
  const _$_WriteOffs(this.form) : super._();

  @override
  final DocumentForm form;

  @override
  String toString() {
    return 'Document.writeOffs(form: $form)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WriteOffs &&
            const DeepCollectionEquality().equals(other.form, form));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(form));

  @JsonKey(ignore: true)
  @override
  _$WriteOffsCopyWith<_WriteOffs> get copyWith =>
      __$WriteOffsCopyWithImpl<_WriteOffs>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> sales) sales,
    required TResult Function(DocumentForm form) purchases,
    required TResult Function(DocumentForm form) expenses,
    required TResult Function(DocumentForm form) writeOffs,
  }) {
    return writeOffs(form);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
  }) {
    return writeOffs?.call(form);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> sales)? sales,
    TResult Function(DocumentForm form)? purchases,
    TResult Function(DocumentForm form)? expenses,
    TResult Function(DocumentForm form)? writeOffs,
    required TResult orElse(),
  }) {
    if (writeOffs != null) {
      return writeOffs(form);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Sales value) sales,
    required TResult Function(_Purchases value) purchases,
    required TResult Function(_Expenses value) expenses,
    required TResult Function(_WriteOffs value) writeOffs,
  }) {
    return writeOffs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
  }) {
    return writeOffs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Sales value)? sales,
    TResult Function(_Purchases value)? purchases,
    TResult Function(_Expenses value)? expenses,
    TResult Function(_WriteOffs value)? writeOffs,
    required TResult orElse(),
  }) {
    if (writeOffs != null) {
      return writeOffs(this);
    }
    return orElse();
  }
}

abstract class _WriteOffs extends Document {
  const factory _WriteOffs(DocumentForm form) = _$_WriteOffs;
  const _WriteOffs._() : super._();

  @override
  DocumentForm get form;
  @override
  @JsonKey(ignore: true)
  _$WriteOffsCopyWith<_WriteOffs> get copyWith =>
      throw _privateConstructorUsedError;
}
