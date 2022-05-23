// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mosque.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MosqueAdapter extends TypeAdapter<Mosque> {
  @override
  final int typeId = 0;

  @override
  Mosque read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mosque(
      id: fields[0] as String?,
      email: fields[1] as String?,
      name: fields[2] as String?,
      phone: fields[3] as String?,
      postcode: fields[4] as String?,
      state: fields[5] as String?,
      address: fields[6] as String?,
      villages: (fields[7] as List?)?.cast<Village>(),
    );
  }

  @override
  void write(BinaryWriter writer, Mosque obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.postcode)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.villages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MosqueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
