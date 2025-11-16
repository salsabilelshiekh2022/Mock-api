import 'package:injectable/injectable.dart';
import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts({int pageNumber = 0});
}

@LazySingleton(as: PostsRemoteDataSource)
class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  PostsRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<PostModel>> getPosts({int pageNumber = 0}) async {
    final response = await _apiConsumer.get(
      EndPoints.posts,
      queryParameters: {'limit': 10, 'skip': pageNumber * 10},
    );

    final postsJson = response['posts'] as List<dynamic>? ?? [];
    return postsJson
        .map((item) => PostModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
