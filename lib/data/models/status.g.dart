// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteStatusAdapter extends TypeAdapter<NoteStatus> {
  @override
  final int typeId = 1;

  @override
  NoteStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NoteStatus.all;
      case 1:
        return NoteStatus.starred;
      case 2:
        return NoteStatus.archive;
      case 3:
        return NoteStatus.trash;
      default:
        return NoteStatus.all;
    }
  }

  @override
  void write(BinaryWriter writer, NoteStatus obj) {
    switch (obj) {
      case NoteStatus.all:
        writer.writeByte(0);
        break;
      case NoteStatus.starred:
        writer.writeByte(1);
        break;
      case NoteStatus.archive:
        writer.writeByte(2);
        break;
      case NoteStatus.trash:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
