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
      bankName: fields[7] as String?,
      bankOwnerName: fields[8] as String?,
      bankAccountNo: fields[9] as String?,
      monthlyFee: fields[10] as double?,
      expireMonth: fields[11] as int?,
      expireYear: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Mosque obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.bankName)
      ..writeByte(8)
      ..write(obj.bankOwnerName)
      ..writeByte(9)
      ..write(obj.bankAccountNo)
      ..writeByte(10)
      ..write(obj.monthlyFee)
      ..writeByte(11)
      ..write(obj.expireMonth)
      ..writeByte(12)
      ..write(obj.expireYear);
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
