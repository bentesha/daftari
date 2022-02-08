// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 1;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record(
      id: fields[0] as String,
      item: fields[3] as Item,
      date: fields[2] as DateTime,
      sellingPrice: fields[6] as double,
      notes: fields[1] as String?,
      quantity: fields[4] as double,
      type: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.notes)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.item)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.sellingPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
