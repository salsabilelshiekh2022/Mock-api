import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final int views;
  final int userId;
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

class ReactionsEntity extends Equatable {
  final int likes;
  final int dislikes;

  const ReactionsEntity({required this.likes, required this.dislikes});

  @override
  List<Object?> get props => [likes, dislikes];
}
