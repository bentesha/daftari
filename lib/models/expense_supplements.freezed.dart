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
      {List<Document> documents = const [],
      required Document document,
      required DateTime date,
      bool isDateAsTitle = true,
      String amount = '',
      String expenseId = '',
      String? description,
      required Category category,
      PageActions action = PageActions.viewing,
      Map<String, String?> errors = const {}}) {
    return _ExpenseSupplements(
      documents: documents,
      document: document,
      date: date,
      isDateAsTitle: isDateAsTitle,
      amount: amount,
      expenseId: expenseId,
      description: description,
      category: category,
      action: action,
      errors: errors,
    );
  }
}

/// @nodoc
const $ExpenseSupplements = _$ExpenseSupplementsTearOff();

/// @nodoc
mixin _$ExpenseSupplements {
  List<Document> get documents =>
      throw _privateConstructorUsedError; //for editing expenses document
  Document get document => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get isDateAsTitle =>
      throw _privateConstructorUsedError; //for editing expenses
  String get amount => throw _privateConstructorUsedError;
  String get expenseId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Category get category => throw _privateConstructorUsedError; //for both
  PageActions get action => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;

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
      {List<Document> documents,
      Document document,
      DateTime date,
      bool isDateAsTitle,
      String amount,
      String expenseId,
      String? description,
      Category category,
      PageActions action,
      Map<String, String?> errors});

  $DocumentCopyWith<$Res> get document;
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
    Object? documents = freezed,
    Object? document = freezed,
    Object? date = freezed,
    Object? isDateAsTitle = freezed,
    Object? amount = freezed,
    Object? expenseId = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? action = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      documents: documents == freezed
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      document: document == freezed
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as Document,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDateAsTitle: isDateAsTitle == freezed
          ? _value.isDateAsTitle
          : isDateAsTitle // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      expenseId: expenseId == freezed
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as PageActions,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }

  @override
  $DocumentCopyWith<$Res> get document {
    return $DocumentCopyWith<$Res>(_value.document, (value) {
      return _then(_value.copyWith(document: value));
    });
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
      {List<Document> documents,
      Document document,
      DateTime date,
      bool isDateAsTitle,
      String amount,
      String expenseId,
      String? description,
      Category category,
      PageActions action,
      Map<String, String?> errors});

  @override
  $DocumentCopyWith<$Res> get document;
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
    Object? documents = freezed,
    Object? document = freezed,
    Object? date = freezed,
    Object? isDateAsTitle = freezed,
    Object? amount = freezed,
    Object? expenseId = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? action = freezed,
    Object? errors = freezed,
  }) {
    return _then(_ExpenseSupplements(
      documents: documents == freezed
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<Document>,
      document: document == freezed
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as Document,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDateAsTitle: isDateAsTitle == freezed
          ? _value.isDateAsTitle
          : isDateAsTitle // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      expenseId: expenseId == freezed
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      action: action == freezed
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as PageActions,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc

class _$_ExpenseSupplements extends _ExpenseSupplements {
  const _$_ExpenseSupplements(
      {this.documents = const [],
      required this.document,
      required this.date,
      this.isDateAsTitle = true,
      this.amount = '',
      this.expenseId = '',
      this.description,
      required this.category,
      this.action = PageActions.viewing,
      this.errors = const {}})
      : super._();

  @JsonKey()
  @override
  final List<Document> documents;
  @override //for editing expenses document
  final Document document;
  @override
  final DateTime date;
  @JsonKey()
  @override
  final bool isDateAsTitle;
  @JsonKey()
  @override //for editing expenses
  final String amount;
  @JsonKey()
  @override
  final String expenseId;
  @override
  final String? description;
  @override
  final Category category;
  @JsonKey()
  @override //for both
  final PageActions action;
  @JsonKey()
  @override
  final Map<String, String?> errors;

  @override
  String toString() {
    return 'ExpenseSupplements(documents: $documents, document: $document, date: $date, isDateAsTitle: $isDateAsTitle, amount: $amount, expenseId: $expenseId, description: $description, category: $category, action: $action, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpenseSupplements &&
            const DeepCollectionEquality().equals(other.documents, documents) &&
            const DeepCollectionEquality().equals(other.document, document) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.isDateAsTitle, isDateAsTitle) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.expenseId, expenseId) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.action, action) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(documents),
      const DeepCollectionEquality().hash(document),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(isDateAsTitle),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(expenseId),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(action),
      const DeepCollectionEquality().hash(errors));

  @JsonKey(ignore: true)
  @override
  _$ExpenseSupplementsCopyWith<_ExpenseSupplements> get copyWith =>
      __$ExpenseSupplementsCopyWithImpl<_ExpenseSupplements>(this, _$identity);
}

abstract class _ExpenseSupplements extends ExpenseSupplements {
  const factory _ExpenseSupplements(
      {List<Document> documents,
      required Document document,
      required DateTime date,
      bool isDateAsTitle,
      String amount,
      String expenseId,
      String? description,
      required Category category,
      PageActions action,
      Map<String, String?> errors}) = _$_ExpenseSupplements;
  const _ExpenseSupplements._() : super._();

  @override
  List<Document> get documents;
  @override //for editing expenses document
  Document get document;
  @override
  DateTime get date;
  @override
  bool get isDateAsTitle;
  @override //for editing expenses
  String get amount;
  @override
  String get expenseId;
  @override
  String? get description;
  @override
  Category get category;
  @override //for both
  PageActions get action;
  @override
  Map<String, String?> get errors;
  @override
  @JsonKey(ignore: true)
  _$ExpenseSupplementsCopyWith<_ExpenseSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
