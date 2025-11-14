import 'package:injectable/injectable.dart';
import 'package:mock_api/core/database/cache/cache_services.dart';
import 'package:mock_api/features/posts/domain/entities/post.dart';
import '../../../../core/database/network/api_consumer.dart';
import '../../../../core/database/network/end_points.dart';
import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostEntity>> getPosts({int pageNumber = 0});
}

@LazySingleton(as: PostsRemoteDataSource)
class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final ApiConsumer _apiConsumer;
  final CacheServices _cacheServices;

  PostsRemoteDataSourceImpl(this._apiConsumer, this._cacheServices);

  @override
  Future<List<PostEntity>> getPosts({int pageNumber = 0}) async {
    final result = await _apiConsumer.handleRequest<List<PostEntity>>(
      request: () => _fetchPostsFromApi(pageNumber),
      onSuccess: (response) => _handleSuccessResponse(response, pageNumber),
    );
    return result.fold((failure) => throw failure, (posts) => posts);
  }

  Future<dynamic> _fetchPostsFromApi(int pageNumber) {
    return _apiConsumer.get(
      EndPoints.posts,
      queryParameters: {'limit': 10, 'skip': pageNumber * 10},
    );
  }

  List<PostEntity> _handleSuccessResponse(dynamic response, int pageNumber) {
    final newPosts = _parsePostsFromResponse(response);
    _updateCache(newPosts, pageNumber);
    return newPosts;
  }

  List<PostEntity> _parsePostsFromResponse(dynamic response) {
    final postsJson = response['posts'] as List<dynamic>? ?? [];
    return postsJson
        .map((item) => PostModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  void _updateCache(List<PostEntity> newPosts, int pageNumber) {
    if (pageNumber == 0) {
      _cacheFirstPage(newPosts);
    } else {
      _appendToCache(newPosts);
    }
  }

  void _cacheFirstPage(List<PostEntity> posts) {
    _cacheServices.clear(CacheHelper.postsBox);
    _cacheServices.storeData<List<PostEntity>>(
      boxName: CacheHelper.postsBox,
      key: "posts",
      data: posts,
    );
  }

  void _appendToCache(List<PostEntity> newPosts) {
    final existingPosts = _getExistingCachedPosts();
    final allPosts = [...existingPosts, ...newPosts];

    _cacheServices.storeData<List<PostEntity>>(
      boxName: CacheHelper.postsBox,
      key: "posts",
      data: allPosts,
    );
  }

  List<PostEntity> _getExistingCachedPosts() {
    return _cacheServices
            .getDataFromCache<List<dynamic>>(
              boxName: CacheHelper.postsBox,
              key: "posts",
            )
            ?.cast<PostEntity>()
            .toList() ??
        [];
  }
}
