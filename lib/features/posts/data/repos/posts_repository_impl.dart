import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mock_api/features/posts/domain/entities/post.dart';

import '../../../../core/database/network/failure.dart';
import '../../../../core/database/network/network_info.dart';
import '../../domain/repos/posts_repository.dart';
import '../data_sources/posts_local_data_source.dart';
import '../data_sources/posts_remote_data_source.dart';

@LazySingleton(as: PostsRepository)
class PostsRepositoryImpl implements PostsRepository {
  PostsRepositoryImpl({
    required PostsRemoteDataSource remoteDataSource,
    required PostsLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  final PostsRemoteDataSource _remoteDataSource;
  final PostsLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts({
    required int pageNumber,
  }) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected && pageNumber == 0) {
      final cachedPosts = _localDataSource.getPosts(pageNumber: pageNumber);
      if (cachedPosts.isNotEmpty) {
        return Right(cachedPosts);
      }

      return Left(ServerFailure(message: 'No Internet connection'));
    }

    if (!isConnected) {
      return Left(ServerFailure(message: 'No Internet connection'));
    }

    final remotePosts = await _remoteDataSource.getPosts(
      pageNumber: pageNumber,
    );
    return Right(remotePosts);
  }
}
