// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../write_off_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$WriteOffSupplementsTearOff {
  const _$WriteOffSupplementsTearOff();

  _WriteOffSupplements call(
      {List<Document> documents = const [],
      required Document document,
      required DateTime date,
      bool isDateAsTitle = true,
      String quantity = '',
      String writeOffId = '',
      required WriteOffTypes type,
      required Product product,
      PageActions action = PageActions.viewing,
      Map<String, String?> errors = const {}}) {
    return _WriteOffSupplements(
      documents: documents,
      document: document,
      date: date,
      isDateAsTitle: isDateAsTitle,
      quantity: quantity,
      writeOffId: writeOffId,
      type: type,
      product: product,
      action: action,
      errors: errors,
    );
  }
}

/// @nodoc
const $WriteOffSupplements = _$WriteOffSupplementsTearOff();

/// @nodoc
mixin _$WriteOffSupplements {
  List<Document> get documents =>
      throw _privateConstructorUsedError; //for editing sales document
  Document get document => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  bool get isDateAsTitle =>
      throw _privateConstructorUsedError; //for editing write-offs
  String get quantity => throw _privateConstructorUsedError;
  String get writeOffId => throw _privateConstructorUsedError;
  WriteOffTypes get type => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError; //for both
  PageActions get action => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WriteOffSupplementsCopyWith<WriteOffSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WriteOffSupplementsCopyWith<$Res> {
  factory $WriteOffSupplementsCopyWith(
          WriteOffSupplements value, $Res Function(WriteOffSupplements) then) =
      _$WriteOffSupplementsCopyWithImpl<$Res>;
  $Res call(
      {List<Document> documents,
      Document document,
      DateTime date,
      bool isDateAsTitle,
      String quantity,
      String writeOffId,
      WriteOffTypes type,
      Product product,
      PageActions action,
      Map<String, String?> errors});

  $DocumentCopyWith<$Res> get document;
}

/// @nodoc
class _$WriteOffSupplementsCopyWithImpl<$Res>
    implements $WriteOffSupplementsCopyWith<$Res> {
  _$WriteOffSupplementsCopyWithImpl(this._value, this._then);

  final WriteOffSupplements _value;
  // ignore: unused_field
  final $Res Function(WriteOffSupplements) _then;

  @override
  $Res call({
    Object? documents = freezed,
    Object? document = freezed,
    Object? date = freezed,
    Object? isDateAsTitle = freezed,
    Object? quantity = freezed,
    Object? writeOffId = freezed,
    Object? type = freezed,
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
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      writeOffId: writeOffId == freezed
          ? _value.writeOffId
          : writeOffId // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WriteOffTypes,
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
abstract class _$WriteOffSupplementsCopyWith<$Res>
    implements $WriteOffSupplementsCopyWith<$Res> {
  factory _$WriteOffSupplementsCopyWith(_WriteOffSupplements value,
          $Res Function(_WriteOffSupplements) then) =
      __$WriteOffSupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Document> documents,
      Document document,
      DateTime date,
      bool isDateAsTitle,
      String quantity,
      String writeOffId,
      WriteOffTypes type,
      Product product,
      PageActions action,
      Map<String, String?> errors});

  @override
  $DocumentCopyWith<$Res> get document;
}

/// @nodoc
class __$WriteOffSupplementsCopyWithImpl<$Res>
    extends _$WriteOffSupplementsCopyWithImpl<$Res>
    implements _$WriteOffSupplementsCopyWith<$Res> {
  __$WriteOffSupplementsCopyWithImpl(
      _WriteOffSupplements _value, $Res Function(_WriteOffSupplements) _then)
      : super(_value, (v) => _then(v as _WriteOffSupplements));

  @override
  _WriteOffSupplements get _value => super._value as _WriteOffSupplements;

  @override
  $Res call({
    Object? documents = freezed,
    Object? document = freezed,
    Object? date = freezed,
    Object? isDateAsTitle = freezed,
    Object? quantity = freezed,
    Object? writeOffId = freezed,
    Object? type = freezed,
    Object? product = freezed,
    Object? action = freezed,
    Object? errors = freezed,
  }) {
    return _then(_WriteOffSupplements(
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
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String,
      writeOffId: writeOffId == freezed
          ? _value.writeOffId
          : writeOffId // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WriteOffTypes,
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

class _$_WriteOffSupplements extends _WriteOffSupplements {
  const _$_WriteOffSupplements(
      {this.documents = const [],
      required this.document,
      required this.date,
      this.isDateAsTitle = true,
      this.quantity = '',
      this.writeOffId = '',
      required this.type,
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
  @override //for editing write-offs
  final String quantity;
  @JsonKey()
  @override
  final String writeOffId;
  @override
  final WriteOffTypes type;
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
    return 'WriteOffSupplements(documents: $documents, document: $document, date: $date, isDateAsTitle: $isDateAsTitle, quantity: $quantity, writeOffId: $writeOffId, type: $type, product: $product, action: $action, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WriteOffSupplements &&
            const DeepCollectionEquality().equals(other.documents, documents) &&
            const DeepCollectionEquality().equals(other.document, document) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.isDateAsTitle, isDateAsTitle) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality()
                .equals(other.writeOffId, writeOffId) &&
            const DeepCollectionEquality().equals(other.type, type) &&
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
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(writeOffId),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(product),
      const DeepCollectionEquality().hash(action),
      const DeepCollectionEquality().hash(errors));

  @JsonKey(ignore: true)
  @override
  _$WriteOffSupplementsCopyWith<_WriteOffSupplements> get copyWith =>
      __$WriteOffSupplementsCopyWithImpl<_WriteOffSupplements>(
          this, _$identity);
}

abstract class _WriteOffSupplements extends WriteOffSupplements {
  const factory _WriteOffSupplements(
      {List<Document> documents,
      required Document document,
      required DateTime date,
      bool isDateAsTitle,
      String quantity,
      String writeOffId,
      required WriteOffTypes type,
      required Product product,
      PageActions action,
      Map<String, String?> errors}) = _$_WriteOffSupplements;
  const _WriteOffSupplements._() : super._();

  @override
  List<Document> get documents;
  @override //for editing sales document
  Document get document;
  @override
  DateTime get date;
  @override
  bool get isDateAsTitle;
  @override //for editing write-offs
  String get quantity;
  @override
  String get writeOffId;
  @override
  WriteOffTypes get type;
  @override
  Product get product;
  @override //for both
  PageActions get action;
  @override
  Map<String, String?> get errors;
  @override
  @JsonKey(ignore: true)
  _$WriteOffSupplementsCopyWith<_WriteOffSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
