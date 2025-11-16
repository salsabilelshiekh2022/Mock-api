import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/post.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostModel {
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
  final ReactionsModel reactions;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.views,
    required this.userId,
    required this.reactions,
  });

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      tags: entity.tags,
      views: entity.views,
      userId: entity.userId,
      reactions: ReactionsModel.fromEntity(entity.reactions),
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      body: body,
      tags: tags,
      views: views,
      userId: userId,
      reactions: reactions.toEntity(),
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      tags: List<String>.from(json['tags']),
      views: json['views'],
      userId: json['userId'],
      reactions: ReactionsModel.fromJson(json['reactions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'views': views,
      'userId': userId,
      'reactions': reactions.toJson(),
    };
  }
}

@HiveType(typeId: 1)
class ReactionsModel {
  @HiveField(0)
  final int likes;

  @HiveField(1)
  final int dislikes;

  ReactionsModel({required this.likes, required this.dislikes});

  factory ReactionsModel.fromEntity(ReactionsEntity entity) {
    return ReactionsModel(likes: entity.likes, dislikes: entity.dislikes);
  }

  ReactionsEntity toEntity() {
    return ReactionsEntity(likes: likes, dislikes: dislikes);
  }

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(likes: json['likes'], dislikes: json['dislikes']);
  }

  Map<String, dynamic> toJson() {
    return {'likes': likes, 'dislikes': dislikes};
  }
}
