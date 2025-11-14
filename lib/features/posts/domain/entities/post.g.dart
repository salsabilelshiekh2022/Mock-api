// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostEntityAdapter extends TypeAdapter<PostEntity> {
  @override
  final int typeId = 0;

  @override
  PostEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      body: fields[2] as String,
      tags: (fields[3] as List).cast<String>(),
      views: fields[4] as int,
      userId: fields[5] as int,
      reactions: fields[6] as ReactionsEntity,
    );
  }

  @override
  void write(BinaryWriter writer, PostEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.views)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.reactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReactionsEntityAdapter extends TypeAdapter<ReactionsEntity> {
  @override
  final int typeId = 1;

  @override
  ReactionsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReactionsEntity(
      likes: fields[0] as int,
      dislikes: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReactionsEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.likes)
      ..writeByte(1)
      ..write(obj.dislikes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReactionsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
