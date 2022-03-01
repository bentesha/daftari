// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_stock_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OpeningStockItemAdapter extends TypeAdapter<OpeningStockItem> {
  @override
  final int typeId = 6;

  @override
  OpeningStockItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OpeningStockItem(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      product: fields[2] as Product,
      unitValue: fields[4] as double,
      quantity: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OpeningStockItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.unitValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpeningStockItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
