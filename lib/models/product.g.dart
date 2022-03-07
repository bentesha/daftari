// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'name': instance.name,
      'unit': instance.unit,
      'unitPrice': instance.unitPrice,
      'categoryId': instance.categoryId,
      'code': Utils.getRandomId(),
    };
