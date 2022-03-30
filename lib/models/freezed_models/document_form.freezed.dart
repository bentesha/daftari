// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../document_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentForm _$DocumentFormFromJson(Map<String, dynamic> json) {
  return _DocumentForm.fromJson(json);
}

/// @nodoc
class _$DocumentFormTearOff {
  const _$DocumentFormTearOff();

  _DocumentForm call(
      {String id = '',
      String title = '',
      String? description,
      double total = 0.0,
      String date = ''}) {
    return _DocumentForm(
      id: id,
      title: title,
      description: description,
      total: total,
      date: date,
    );
  }

  DocumentForm fromJson(Map<String, Object?> json) {
    return DocumentForm.fromJson(json);
  }
}

/// @nodoc
const $DocumentForm = _$DocumentFormTearOff();

/// @nodoc
mixin _$DocumentForm {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentFormCopyWith<DocumentForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentFormCopyWith<$Res> {
  factory $DocumentFormCopyWith(
          DocumentForm value, $Res Function(DocumentForm) then) =
      _$DocumentFormCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String? description,
      double total,
      String date});
}

/// @nodoc
class _$DocumentFormCopyWithImpl<$Res> implements $DocumentFormCopyWith<$Res> {
  _$DocumentFormCopyWithImpl(this._value, this._then);

  final DocumentForm _value;
  // ignore: unused_field
  final $Res Function(DocumentForm) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? total = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$DocumentFormCopyWith<$Res>
    implements $DocumentFormCopyWith<$Res> {
  factory _$DocumentFormCopyWith(
          _DocumentForm value, $Res Function(_DocumentForm) then) =
      __$DocumentFormCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String? description,
      double total,
      String date});
}

/// @nodoc
class __$DocumentFormCopyWithImpl<$Res> extends _$DocumentFormCopyWithImpl<$Res>
    implements _$DocumentFormCopyWith<$Res> {
  __$DocumentFormCopyWithImpl(
      _DocumentForm _value, $Res Function(_DocumentForm) _then)
      : super(_value, (v) => _then(v as _DocumentForm));

  @override
  _DocumentForm get _value => super._value as _DocumentForm;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? total = freezed,
    Object? date = freezed,
  }) {
    return _then(_DocumentForm(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DocumentForm extends _DocumentForm {
  const _$_DocumentForm(
      {this.id = '',
      this.title = '',
      this.description,
      this.total = 0.0,
      this.date = ''})
      : super._();

  factory _$_DocumentForm.fromJson(Map<String, dynamic> json) =>
      _$$_DocumentFormFromJson(json);

  @JsonKey()
  @override
  final String id;
  @JsonKey()
  @override
  final String title;
  @override
  final String? description;
  @JsonKey()
  @override
  final double total;
  @JsonKey()
  @override
  final String date;

  @override
  String toString() {
    return 'DocumentForm(id: $id, title: $title, description: $description, total: $total, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DocumentForm &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.total, total) &&
            const DeepCollectionEquality().equals(other.date, date));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(total),
      const DeepCollectionEquality().hash(date));

  @JsonKey(ignore: true)
  @override
  _$DocumentFormCopyWith<_DocumentForm> get copyWith =>
      __$DocumentFormCopyWithImpl<_DocumentForm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DocumentFormToJson(this);
  }
}

abstract class _DocumentForm extends DocumentForm {
  const factory _DocumentForm(
      {String id,
      String title,
      String? description,
      double total,
      String date}) = _$_DocumentForm;
  const _DocumentForm._() : super._();

  factory _DocumentForm.fromJson(Map<String, dynamic> json) =
      _$_DocumentForm.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  double get total;
  @override
  String get date;
  @override
  @JsonKey(ignore: true)
  _$DocumentFormCopyWith<_DocumentForm> get copyWith =>
      throw _privateConstructorUsedError;
}
