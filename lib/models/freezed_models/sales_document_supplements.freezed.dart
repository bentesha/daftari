// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../sales_document_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SalesDocumentSupplementsTearOff {
  const _$SalesDocumentSupplementsTearOff();

  _SalesDocumentSupplements call(
      {List<Document> documents = const [],
      required Document document,
      required DateTime date,
      bool isDateAsTitle = true,
      String salesId = '',
      String quantity = '',
      String unitPrice = '',
      required Product product,
      PageActions action = PageActions.viewing,
      Map<String, String?> errors = const {}}) {
    return _SalesDocumentSupplements(
      documents: documents,
      document: document,
      date: date,
      isDateAsTitle: isDateAsTitle,
      salesId: salesId,
      quantity: quantity,
      unitPrice: unitPrice,
      product: product,
      action: action,
      errors: errors,
    );
  }
}

/// @nodoc
const $SalesDocumentSupplements = _$SalesDocumentSupplementsTearOff();

/// @nodoc
mixin _$SalesDocumentSupplements {
  List<Document> get documents =>
      throw _privateConstructorUsedError; //for editing sales document
  Document get document => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get isDateAsTitle =>
      throw _privateConstructorUsedError; //for editing sales
  String get salesId => throw _privateConstructorUsedError;
  String get quantity => throw _privateConstructorUsedError;
  String get unitPrice => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError; //for both
  PageActions get action => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SalesDocumentSupplementsCopyWith<SalesDocumentSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesDocumentSupplementsCopyWith<$Res> {
  factory $SalesDocumentSupplementsCopyWith(SalesDocumentSupplements value,
          $Res Function(SalesDocumentSupplements) then) =
      _$SalesDocumentSupplementsCopyWithImpl<$Res>;
  $Res call(
      {List<Document> documents,
      Document document,
      DateTime date,
      bool isDateAsTitle,
      String salesId,
      String quantity,
      String unitPrice,
      Product product,
      PageActions action,
      Map<String, String?> errors});

  $DocumentCopyWith<$Res> get document;
}

/// @nodoc
class _$SalesDocumentSupplementsCopyWithImpl<$Res>
    implements $SalesDocumentSupplementsCopyWith<$Res> {
  _$SalesDocumentSupplementsCopyWithImpl(this._value, this._then);

  final SalesDocumentSupplements _value;
  // ignore: unused_field
  final $Res Function(SalesDocumentSupplements) _then;

  @override
  $Res call({
    Object? documents = freezed,
    Object? document = freezed,
    Object? date = freezed,
    Object? isDateAsTitle = freezed,
    Object? salesId = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? product = freezed,
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
      salesId: salesId == freezed
          ? _value.salesId
          : salesId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: unitPrice == freezed
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
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
abstract class _$SalesDocumentSupplementsCopyWith<$Res>
    implements $SalesDocumentSupplementsCopyWith<$Res> {
  factory _$SalesDocumentSupplementsCopyWith(_SalesDocumentSupplements value,
          $Res Function(_SalesDocumentSupplements) then) =
      __$SalesDocumentSupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Document> documents,
      Document document,
      DateTime date,
      bool isDateAsTitle,
      String salesId,
      String quantity,
      String unitPrice,
      Product product,
      PageActions action,
      Map<String, String?> errors});

  @override
  $DocumentCopyWith<$Res> get document;
}

/// @nodoc
class __$SalesDocumentSupplementsCopyWithImpl<$Res>
    extends _$SalesDocumentSupplementsCopyWithImpl<$Res>
    implements _$SalesDocumentSupplementsCopyWith<$Res> {
  __$SalesDocumentSupplementsCopyWithImpl(_SalesDocumentSupplements _value,
      $Res Function(_SalesDocumentSupplements) _then)
      : super(_value, (v) => _then(v as _SalesDocumentSupplements));

  @override
  _SalesDocumentSupplements get _value =>
      super._value as _SalesDocumentSupplements;

  @override
  $Res call({
    Object? documents = freezed,
    Object? document = freezed,
    Object? date = freezed,
    Object? isDateAsTitle = freezed,
    Object? salesId = freezed,
    Object? quantity = freezed,
    Object? unitPrice = freezed,
    Object? product = freezed,
    Object? action = freezed,
    Object? errors = freezed,
  }) {
    return _then(_SalesDocumentSupplements(
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
      salesId: salesId == freezed
          ? _value.salesId
          : salesId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      unitPrice: unitPrice == freezed
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as String,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
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

class _$_SalesDocumentSupplements extends _SalesDocumentSupplements {
  const _$_SalesDocumentSupplements(
      {this.documents = const [],
      required this.document,
      required this.date,
      this.isDateAsTitle = true,
      this.salesId = '',
      this.quantity = '',
      this.unitPrice = '',
      required this.product,
      this.action = PageActions.viewing,
      this.errors = const {}})
      : super._();

  @JsonKey()
  @override
  final List<Document> documents;
  @override //for editing sales document
  final Document document;
  @override
  final DateTime date;
  @JsonKey()
  @override
  final bool isDateAsTitle;
  @JsonKey()
  @override //for editing sales
  final String salesId;
  @JsonKey()
  @override
  final String quantity;
  @JsonKey()
  @override
  final String unitPrice;
  @override
  final Product product;
  @JsonKey()
  @override //for both
  final PageActions action;
  @JsonKey()
  @override
  final Map<String, String?> errors;

  @override
  String toString() {
    return 'SalesDocumentSupplements(documents: $documents, document: $document, date: $date, isDateAsTitle: $isDateAsTitle, salesId: $salesId, quantity: $quantity, unitPrice: $unitPrice, product: $product, action: $action, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SalesDocumentSupplements &&
            const DeepCollectionEquality().equals(other.documents, documents) &&
            const DeepCollectionEquality().equals(other.document, document) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.isDateAsTitle, isDateAsTitle) &&
            const DeepCollectionEquality().equals(other.salesId, salesId) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.unitPrice, unitPrice) &&
            const DeepCollectionEquality().equals(other.product, product) &&
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
      const DeepCollectionEquality().hash(salesId),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(unitPrice),
      const DeepCollectionEquality().hash(product),
      const DeepCollectionEquality().hash(action),
      const DeepCollectionEquality().hash(errors));

  @JsonKey(ignore: true)
  @override
  _$SalesDocumentSupplementsCopyWith<_SalesDocumentSupplements> get copyWith =>
      __$SalesDocumentSupplementsCopyWithImpl<_SalesDocumentSupplements>(
          this, _$identity);
}

abstract class _SalesDocumentSupplements extends SalesDocumentSupplements {
  const factory _SalesDocumentSupplements(
      {List<Document> documents,
      required Document document,
      required DateTime date,
      bool isDateAsTitle,
      String salesId,
      String quantity,
      String unitPrice,
      required Product product,
      PageActions action,
      Map<String, String?> errors}) = _$_SalesDocumentSupplements;
  const _SalesDocumentSupplements._() : super._();

  @override
  List<Document> get documents;
  @override //for editing sales document
  Document get document;
  @override
  DateTime get date;
  @override
  bool get isDateAsTitle;
  @override //for editing sales
  String get salesId;
  @override
  String get quantity;
  @override
  String get unitPrice;
  @override
  Product get product;
  @override //for both
  PageActions get action;
  @override
  Map<String, String?> get errors;
  @override
  @JsonKey(ignore: true)
  _$SalesDocumentSupplementsCopyWith<_SalesDocumentSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
