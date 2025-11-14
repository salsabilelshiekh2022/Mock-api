import '../../domain/entities/post.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.tags,
    required super.views,
    required super.userId,
    required super.reactions,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final reactionsJson = json['reactions'];
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      tags: List<String>.from(json['tags'] as List<dynamic>),
      views: json['views'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      reactions: ReactionsModel.fromJson(
        Map<String, dynamic>.from(
          reactionsJson is Map
              ? reactionsJson
              : <String, dynamic>{'likes': 0, 'dislikes': 0},
        ),
      ),
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
      'reactions': ReactionsModel.fromEntity(reactions).toJson(),
    };
  }

  static List<PostModel> fromJsonList(List<dynamic> list) {
    return list
        .map((item) => PostModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}

class ReactionsModel extends ReactionsEntity {
  const ReactionsModel({required super.likes, required super.dislikes});

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      likes: json['likes'] as int? ?? 0,
      dislikes: json['dislikes'] as int? ?? 0,
    );
  }

  factory ReactionsModel.fromEntity(ReactionsEntity entity) {
    return ReactionsModel(likes: entity.likes, dislikes: entity.dislikes);
  }

  Map<String, dynamic> toJson() {
    return {'likes': likes, 'dislikes': dislikes};
  }
}
