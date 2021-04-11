// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ModelProducts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatumAdapter extends TypeAdapter<Datum> {
  @override
  final int typeId = 1;

  @override
  Datum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datum(
      id: fields[0] as int?,
      type: fields[1] as String?,
      rate: fields[2] as String?,
      name: fields[3] as String?,
      images: (fields[4] as List?)?.cast<String>(),
      vars: (fields[5] as List?)?.cast<Var>(),
      brand: fields[6] as String?,
      description: fields[7] as String?,
      slug: fields[8] as String?,
      requireShipping: fields[9] as String?,
      weight: fields[10] as String?,
      sku: fields[11] as String?,
      price: fields[12] as String?,
      stock: fields[13] as String?,
      posPrice: fields[14] as String?,
      websitePrice: fields[15] as String?,
      discount: fields[16] as String?,
      posDiscount: fields[17] as String?,
      websiteDiscount: fields[18] as String?,
      discountTo: fields[19] as String?,
      qnt: fields[20] as String?,
      subtitle: fields[21] as String?,
      seoTitle: fields[22] as String?,
      seoDescription: fields[23] as String?,
      seoKeywords: fields[24] as String?,
      fee: fields[25] as String?,
      trend: fields[26] as int?,
      enabled: fields[27] as int?,
      createdAt: fields[28] as DateTime?,
      updatedAt: fields[29] as DateTime?,
      resourceUrl: fields[30] as String?,
      tag: (fields[31] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Datum obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.rate)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.vars)
      ..writeByte(6)
      ..write(obj.brand)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.slug)
      ..writeByte(9)
      ..write(obj.requireShipping)
      ..writeByte(10)
      ..write(obj.weight)
      ..writeByte(11)
      ..write(obj.sku)
      ..writeByte(12)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.stock)
      ..writeByte(14)
      ..write(obj.posPrice)
      ..writeByte(15)
      ..write(obj.websitePrice)
      ..writeByte(16)
      ..write(obj.discount)
      ..writeByte(17)
      ..write(obj.posDiscount)
      ..writeByte(18)
      ..write(obj.websiteDiscount)
      ..writeByte(19)
      ..write(obj.discountTo)
      ..writeByte(20)
      ..write(obj.qnt)
      ..writeByte(21)
      ..write(obj.subtitle)
      ..writeByte(22)
      ..write(obj.seoTitle)
      ..writeByte(23)
      ..write(obj.seoDescription)
      ..writeByte(24)
      ..write(obj.seoKeywords)
      ..writeByte(25)
      ..write(obj.fee)
      ..writeByte(26)
      ..write(obj.trend)
      ..writeByte(27)
      ..write(obj.enabled)
      ..writeByte(28)
      ..write(obj.createdAt)
      ..writeByte(29)
      ..write(obj.updatedAt)
      ..writeByte(30)
      ..write(obj.resourceUrl)
      ..writeByte(31)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VarAdapter extends TypeAdapter<Var> {
  @override
  final int typeId = 2;

  @override
  Var read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Var(
      name: fields[0] as String?,
      type: fields[1] as String?,
      rel: fields[2] as String?,
      value: (fields[3] as List?)?.cast<Value>(),
    );
  }

  @override
  void write(BinaryWriter writer, Var obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.rel)
      ..writeByte(3)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ValueAdapter extends TypeAdapter<Value> {
  @override
  final int typeId = 3;

  @override
  Value read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Value(
      label: fields[0] as String?,
      color: fields[1] as String?,
      price: fields[2] as String?,
      cost: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Value obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.cost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
