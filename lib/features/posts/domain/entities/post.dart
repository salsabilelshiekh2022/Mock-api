import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'post.g.dart';

@HiveType(typeId: 0)
class PostEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final List<String> tags;
  @HiveField(4)
  final int views;
  @HiveField(5)
  final int userId;
  @HiveField(6)
  final ReactionsEntity reactions;

  const PostEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.views,
    required this.userId,
    required this.reactions,
  });

  @override
  List<Object?> get props => [id, title, body, tags, views, userId, reactions];
}

@HiveType(typeId: 1)
class ReactionsEntity extends Equatable {
  @HiveField(0)
  final int likes;
  @HiveField(1)
  final int dislikes;

  const ReactionsEntity({required this.likes, required this.dislikes});

  @override
  List<Object?> get props => [likes, dislikes];
}


