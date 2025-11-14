import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/network/failure.dart';
import '../entities/post.dart';
import '../repos/posts_repository.dart';

@injectable
class GetPostsUseCase {
  final PostsRepository _repository;

  const GetPostsUseCase(this._repository);

  Future<Either<Failure, List<PostEntity>>> call(int pageNumber) async {
    return _repository.getPosts(pageNumber: pageNumber);
  }
}


