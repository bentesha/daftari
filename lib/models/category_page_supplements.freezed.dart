// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category_page_supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CategoryPageSupplementsTearOff {
  const _$CategoryPageSupplementsTearOff();

  _CategoryPageSupplements call(
      {required Category category,
      required List<Category> categoryList,
      required List<Product> productList,
      required Map<String, String?> errors}) {
    return _CategoryPageSupplements(
      category: category,
      categoryList: categoryList,
      productList: productList,
      errors: errors,
    );
  }
}

/// @nodoc
const $CategoryPageSupplements = _$CategoryPageSupplementsTearOff();

/// @nodoc
mixin _$CategoryPageSupplements {
  Category get category => throw _privateConstructorUsedError;
  List<Category> get categoryList => throw _privateConstructorUsedError;
  List<Product> get productList => throw _privateConstructorUsedError;
  Map<String, String?> get errors => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryPageSupplementsCopyWith<CategoryPageSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryPageSupplementsCopyWith<$Res> {
  factory $CategoryPageSupplementsCopyWith(CategoryPageSupplements value,
          $Res Function(CategoryPageSupplements) then) =
      _$CategoryPageSupplementsCopyWithImpl<$Res>;
  $Res call(
      {Category category,
      List<Category> categoryList,
      List<Product> productList,
      Map<String, String?> errors});

  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class _$CategoryPageSupplementsCopyWithImpl<$Res>
    implements $CategoryPageSupplementsCopyWith<$Res> {
  _$CategoryPageSupplementsCopyWithImpl(this._value, this._then);

  final CategoryPageSupplements _value;
  // ignore: unused_field
  final $Res Function(CategoryPageSupplements) _then;

  @override
  $Res call({
    Object? category = freezed,
    Object? categoryList = freezed,
    Object? productList = freezed,
    Object? errors = freezed,
  }) {
    return _then(_value.copyWith(
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      categoryList: categoryList == freezed
          ? _value.categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      productList: productList == freezed
          ? _value.productList
          : productList // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }

  @override
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }
}

/// @nodoc
abstract class _$CategoryPageSupplementsCopyWith<$Res>
    implements $CategoryPageSupplementsCopyWith<$Res> {
  factory _$CategoryPageSupplementsCopyWith(_CategoryPageSupplements value,
          $Res Function(_CategoryPageSupplements) then) =
      __$CategoryPageSupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {Category category,
      List<Category> categoryList,
      List<Product> productList,
      Map<String, String?> errors});

  @override
  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class __$CategoryPageSupplementsCopyWithImpl<$Res>
    extends _$CategoryPageSupplementsCopyWithImpl<$Res>
    implements _$CategoryPageSupplementsCopyWith<$Res> {
  __$CategoryPageSupplementsCopyWithImpl(_CategoryPageSupplements _value,
      $Res Function(_CategoryPageSupplements) _then)
      : super(_value, (v) => _then(v as _CategoryPageSupplements));

  @override
  _CategoryPageSupplements get _value =>
      super._value as _CategoryPageSupplements;

  @override
  $Res call({
    Object? category = freezed,
    Object? categoryList = freezed,
    Object? productList = freezed,
    Object? errors = freezed,
  }) {
    return _then(_CategoryPageSupplements(
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      categoryList: categoryList == freezed
          ? _value.categoryList
          : categoryList // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      productList: productList == freezed
          ? _value.productList
          : productList // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      errors: errors == freezed
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
    ));
  }
}

/// @nodoc

class _$_CategoryPageSupplements extends _CategoryPageSupplements {
  const _$_CategoryPageSupplements(
      {required this.category,
      required this.categoryList,
      required this.productList,
      required this.errors})
      : super._();

  @override
  final Category category;
  @override
  final List<Category> categoryList;
  @override
  final List<Product> productList;
  @override
  final Map<String, String?> errors;

  @override
  String toString() {
    return 'CategoryPageSupplements(category: $category, categoryList: $categoryList, productList: $productList, errors: $errors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryPageSupplements &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality()
                .equals(other.categoryList, categoryList) &&
            const DeepCollectionEquality()
                .equals(other.productList, productList) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(categoryList),
      const DeepCollectionEquality().hash(productList),
      const DeepCollectionEquality().hash(errors));

  @JsonKey(ignore: true)
  @override
  _$CategoryPageSupplementsCopyWith<_CategoryPageSupplements> get copyWith =>
      __$CategoryPageSupplementsCopyWithImpl<_CategoryPageSupplements>(
          this, _$identity);
}

abstract class _CategoryPageSupplements extends CategoryPageSupplements {
  const factory _CategoryPageSupplements(
      {required Category category,
      required List<Category> categoryList,
      required List<Product> productList,
      required Map<String, String?> errors}) = _$_CategoryPageSupplements;
  const _CategoryPageSupplements._() : super._();

  @override
  Category get category;
  @override
  List<Category> get categoryList;
  @override
  List<Product> get productList;
  @override
  Map<String, String?> get errors;
  @override
  @JsonKey(ignore: true)
  _$CategoryPageSupplementsCopyWith<_CategoryPageSupplements> get copyWith =>
      throw _privateConstructorUsedError;
}
