// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../write_off.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WriteOff _$$_WriteOffFromJson(Map<String, dynamic> json) => _$_WriteOff(
      id: json['id'] as String? ?? '',
      documentId: json['documentId'] as String? ?? '',
      productId: json['productId'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$_WriteOffToJson(_$_WriteOff instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
