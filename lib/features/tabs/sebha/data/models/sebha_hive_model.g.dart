// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sebha_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SebhaHiveModelAdapter extends TypeAdapter<SebhaHiveModel> {
  @override
  final int typeId = 0;

  @override
  SebhaHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SebhaHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      dhikr: fields[2] as String,
      count: fields[3] as int,
      target: fields[4] as int,
      lastUpdated: fields[5] as DateTime,
      isCountable: fields[6] == null ? true : fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SebhaHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dhikr)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.target)
      ..writeByte(5)
      ..write(obj.lastUpdated)
      ..writeByte(6)
      ..write(obj.isCountable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SebhaHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
