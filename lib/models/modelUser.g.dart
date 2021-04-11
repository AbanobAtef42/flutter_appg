// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelUser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      phone: fields[3] as String?,
      email: fields[4] as String?,
      address: fields[5] as String?,
      countyId: fields[6] as String?,
      govId: fields[7] as String?,
      cityId: fields[8] as String?,
      info: fields[9] as String?,
      login: fields[10] as int?,
      deletedAt: fields[11] as String?,
      createdAt: fields[12] as String?,
      updatedAt: fields[13] as String?,
      fullName: fields[14] as String?,
      resourceUrl: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.countyId)
      ..writeByte(7)
      ..write(obj.govId)
      ..writeByte(8)
      ..write(obj.cityId)
      ..writeByte(9)
      ..write(obj.info)
      ..writeByte(10)
      ..write(obj.login)
      ..writeByte(11)
      ..write(obj.deletedAt)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.fullName)
      ..writeByte(15)
      ..write(obj.resourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
