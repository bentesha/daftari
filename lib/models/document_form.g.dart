// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DocumentForm _$$_DocumentFormFromJson(Map<String, dynamic> json) =>
    _$_DocumentForm(
      id: json['id'] as String? ?? '',
      description: json['description'] as String?,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] as String? ?? '',
    );

Map<String, dynamic> _$$_DocumentFormToJson(_$_DocumentForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'total': instance.total,
      'date': instance.date,
    };
