// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'village.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VillageAdapter extends TypeAdapter<Village> {
  @override
  final int typeId = 1;

  @override
  Village read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Village(
      id: fields[0] as String?,
      name: fields[1] as String?,
      address: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Village obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VillageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
