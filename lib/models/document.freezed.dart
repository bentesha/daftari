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

  _Sales sales(DocumentForm form, List<Sales> salesList) {
    return _Sales(
      form,
      salesList,
    );
  }

  _Purchases purchases(DocumentForm form, List<Purchase> purchaseList) {
    return _Purchases(
      form,
      purchaseList,
    );
  }

  _Expenses expenses(DocumentForm form, List<Expense> expenseList) {
    return _Expenses(
      form,
      expenseList,
    );
  }

  _WriteOffs writeOffs(
      DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList) {
    return _WriteOffs(
      form,
      type,
      writeOffList,
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
    required TResult Function(DocumentForm form, List<Sales> salesList) sales,
    required TResult Function(DocumentForm form, List<Purchase> purchaseList)
        purchases,
    required TResult Function(DocumentForm form, List<Expense> expenseList)
        expenses,
    required TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)
        writeOffs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
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
  $Res call({DocumentForm form, List<Sales> salesList});

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
    Object? salesList = freezed,
  }) {
    return _then(_Sales(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
      salesList == freezed
          ? _value.salesList
          : salesList // ignore: cast_nullable_to_non_nullable
              as List<Sales>,
    ));
  }
}

/// @nodoc

class _$_Sales extends _Sales {
  const _$_Sales(this.form, this.salesList) : super._();

  @override
  final DocumentForm form;
  @override
  final List<Sales> salesList;

  @override
  String toString() {
    return 'Document.sales(form: $form, salesList: $salesList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Sales &&
            const DeepCollectionEquality().equals(other.form, form) &&
            const DeepCollectionEquality().equals(other.salesList, salesList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(form),
      const DeepCollectionEquality().hash(salesList));

  @JsonKey(ignore: true)
  @override
  _$SalesCopyWith<_Sales> get copyWith =>
      __$SalesCopyWithImpl<_Sales>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> salesList) sales,
    required TResult Function(DocumentForm form, List<Purchase> purchaseList)
        purchases,
    required TResult Function(DocumentForm form, List<Expense> expenseList)
        expenses,
    required TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)
        writeOffs,
  }) {
    return sales(form, salesList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
  }) {
    return sales?.call(form, salesList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
    required TResult orElse(),
  }) {
    if (sales != null) {
      return sales(form, salesList);
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
  const factory _Sales(DocumentForm form, List<Sales> salesList) = _$_Sales;
  const _Sales._() : super._();

  @override
  DocumentForm get form;
  List<Sales> get salesList;
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
  $Res call({DocumentForm form, List<Purchase> purchaseList});

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
    Object? purchaseList = freezed,
  }) {
    return _then(_Purchases(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
      purchaseList == freezed
          ? _value.purchaseList
          : purchaseList // ignore: cast_nullable_to_non_nullable
              as List<Purchase>,
    ));
  }
}

/// @nodoc

class _$_Purchases extends _Purchases {
  const _$_Purchases(this.form, this.purchaseList) : super._();

  @override
  final DocumentForm form;
  @override
  final List<Purchase> purchaseList;

  @override
  String toString() {
    return 'Document.purchases(form: $form, purchaseList: $purchaseList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Purchases &&
            const DeepCollectionEquality().equals(other.form, form) &&
            const DeepCollectionEquality()
                .equals(other.purchaseList, purchaseList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(form),
      const DeepCollectionEquality().hash(purchaseList));

  @JsonKey(ignore: true)
  @override
  _$PurchasesCopyWith<_Purchases> get copyWith =>
      __$PurchasesCopyWithImpl<_Purchases>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> salesList) sales,
    required TResult Function(DocumentForm form, List<Purchase> purchaseList)
        purchases,
    required TResult Function(DocumentForm form, List<Expense> expenseList)
        expenses,
    required TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)
        writeOffs,
  }) {
    return purchases(form, purchaseList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
  }) {
    return purchases?.call(form, purchaseList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
    required TResult orElse(),
  }) {
    if (purchases != null) {
      return purchases(form, purchaseList);
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
  const factory _Purchases(DocumentForm form, List<Purchase> purchaseList) =
      _$_Purchases;
  const _Purchases._() : super._();

  @override
  DocumentForm get form;
  List<Purchase> get purchaseList;
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
  $Res call({DocumentForm form, List<Expense> expenseList});

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
    Object? expenseList = freezed,
  }) {
    return _then(_Expenses(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
      expenseList == freezed
          ? _value.expenseList
          : expenseList // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
    ));
  }
}

/// @nodoc

class _$_Expenses extends _Expenses {
  const _$_Expenses(this.form, this.expenseList) : super._();

  @override
  final DocumentForm form;
  @override
  final List<Expense> expenseList;

  @override
  String toString() {
    return 'Document.expenses(form: $form, expenseList: $expenseList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Expenses &&
            const DeepCollectionEquality().equals(other.form, form) &&
            const DeepCollectionEquality()
                .equals(other.expenseList, expenseList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(form),
      const DeepCollectionEquality().hash(expenseList));

  @JsonKey(ignore: true)
  @override
  _$ExpensesCopyWith<_Expenses> get copyWith =>
      __$ExpensesCopyWithImpl<_Expenses>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> salesList) sales,
    required TResult Function(DocumentForm form, List<Purchase> purchaseList)
        purchases,
    required TResult Function(DocumentForm form, List<Expense> expenseList)
        expenses,
    required TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)
        writeOffs,
  }) {
    return expenses(form, expenseList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
  }) {
    return expenses?.call(form, expenseList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
    required TResult orElse(),
  }) {
    if (expenses != null) {
      return expenses(form, expenseList);
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
  const factory _Expenses(DocumentForm form, List<Expense> expenseList) =
      _$_Expenses;
  const _Expenses._() : super._();

  @override
  DocumentForm get form;
  List<Expense> get expenseList;
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
  $Res call(
      {DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList});

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
    Object? type = freezed,
    Object? writeOffList = freezed,
  }) {
    return _then(_WriteOffs(
      form == freezed
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as DocumentForm,
      type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WriteOffTypes,
      writeOffList == freezed
          ? _value.writeOffList
          : writeOffList // ignore: cast_nullable_to_non_nullable
              as List<WriteOff>,
    ));
  }
}

/// @nodoc

class _$_WriteOffs extends _WriteOffs {
  const _$_WriteOffs(this.form, this.type, this.writeOffList) : super._();

  @override
  final DocumentForm form;
  @override
  final WriteOffTypes type;
  @override
  final List<WriteOff> writeOffList;

  @override
  String toString() {
    return 'Document.writeOffs(form: $form, type: $type, writeOffList: $writeOffList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WriteOffs &&
            const DeepCollectionEquality().equals(other.form, form) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.writeOffList, writeOffList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(form),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(writeOffList));

  @JsonKey(ignore: true)
  @override
  _$WriteOffsCopyWith<_WriteOffs> get copyWith =>
      __$WriteOffsCopyWithImpl<_WriteOffs>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DocumentForm form, List<Sales> salesList) sales,
    required TResult Function(DocumentForm form, List<Purchase> purchaseList)
        purchases,
    required TResult Function(DocumentForm form, List<Expense> expenseList)
        expenses,
    required TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)
        writeOffs,
  }) {
    return writeOffs(form, type, writeOffList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
  }) {
    return writeOffs?.call(form, type, writeOffList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DocumentForm form, List<Sales> salesList)? sales,
    TResult Function(DocumentForm form, List<Purchase> purchaseList)? purchases,
    TResult Function(DocumentForm form, List<Expense> expenseList)? expenses,
    TResult Function(
            DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList)?
        writeOffs,
    required TResult orElse(),
  }) {
    if (writeOffs != null) {
      return writeOffs(form, type, writeOffList);
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
  const factory _WriteOffs(
          DocumentForm form, WriteOffTypes type, List<WriteOff> writeOffList) =
      _$_WriteOffs;
  const _WriteOffs._() : super._();

  @override
  DocumentForm get form;
  WriteOffTypes get type;
  List<WriteOff> get writeOffList;
  @override
  @JsonKey(ignore: true)
  _$WriteOffsCopyWith<_WriteOffs> get copyWith =>
      throw _privateConstructorUsedError;
}
