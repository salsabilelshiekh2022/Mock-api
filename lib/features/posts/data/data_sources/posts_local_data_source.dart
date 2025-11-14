import 'package:injectable/injectable.dart';
import 'package:mock_api/features/posts/domain/entities/post.dart';

import '../../../../core/database/cache/cache_services.dart';

abstract class PostsLocalDataSource {
  List<PostEntity> getPosts({int pageNumber = 0});
}

@LazySingleton(as: PostsLocalDataSource)
class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final CacheServices _cacheServices;

  PostsLocalDataSourceImpl(this._cacheServices);

  @override
  List<PostEntity> getPosts({int pageNumber = 0}) {
    final data = _cacheServices.getDataFromCache<List<dynamic>>(
      boxName: CacheHelper.postsBox,
      key: "posts",
    );
    return data?.cast<PostEntity>().toList() ?? [];
  }
}
