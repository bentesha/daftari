// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_off.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WriteOffAdapter extends TypeAdapter<WriteOff> {
  @override
  final int typeId = 5;

  @override
  WriteOff read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WriteOff(
      id: fields[0] as String,
      groupId: fields[1] as String,
      product: fields[2] as Product,
      quantity: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WriteOff obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.groupId)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WriteOffAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
