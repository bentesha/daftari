// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Sales _$$_SalesFromJson(Map<String, dynamic> json) => _$_Sales(
      id: json['id'] as String? ?? '',
      documentId: json['documentId'] as String? ?? '',
      sort: (json['sort'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      productId: json['productId'] as String? ?? '',
    );

Map<String, dynamic> _$$_SalesToJson(_$_Sales instance) => <String, dynamic>{
      'id': instance.id,
      'documentId': instance.documentId,
      'sort': instance.sort,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'total': instance.total,
      'productId': instance.productId,
    };
