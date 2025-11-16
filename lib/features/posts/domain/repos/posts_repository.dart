import 'package:dartz/dartz.dart';

import '../../../../core/database/network/failure.dart';
import '../entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts({required int pageNumber});
}

