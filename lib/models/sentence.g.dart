// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SentenceAdapter extends TypeAdapter<Sentence> {
  @override
  final int typeId = 0;

  @override
  Sentence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sentence(
      sentence: fields[0] as String,
      stars: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Sentence obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sentence)
      ..writeByte(1)
      ..write(obj.stars);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SentenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
