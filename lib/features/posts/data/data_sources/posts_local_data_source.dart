import 'package:injectable/injectable.dart';
import '../../../../core/database/cache/cache_services.dart';
import '../models/post_model.dart';

abstract class PostsLocalDataSource {
  List<PostModel> getPosts();
  void cachePosts(List<PostModel> posts);
  void clearCache();
}

@LazySingleton(as: PostsLocalDataSource)
class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final CacheServices _cacheServices;

  PostsLocalDataSourceImpl(this._cacheServices);

  @override
  List<PostModel> getPosts() {
    final data = _cacheServices.getDataFromCache<List<dynamic>>(
      boxName: CacheHelper.postsBox,
      key: "posts",
    );
    return data?.cast<PostModel>().toList() ?? [];
  }

  @override
  void cachePosts(List<PostModel> posts) {
    _cacheServices.storeData<List<PostModel>>(
      boxName: CacheHelper.postsBox,
      key: "posts",
      data: posts,
    );
  }

  @override
  void clearCache() {
    _cacheServices.clear(CacheHelper.postsBox);
  }
}
