import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/entities/post.dart';
import '../../domain/use_cases/get_posts_use_case.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required GetPostsUseCase getPostsUseCase})
    : _getPostsUseCase = getPostsUseCase,

      super(const PostsState());

  final GetPostsUseCase _getPostsUseCase;

  Future<void> getPosts({required int pageNumber}) async {
    emit(
      state.copyWith(
        status: pageNumber == 0
            ? RequestStatus.loading
            : RequestStatus.loadingMore,
      ),
    );

    final page = await _getPostsUseCase.call(pageNumber);

    page.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (posts) {
        final updatedPosts = pageNumber == 0
            ? posts
            : [...state.posts, ...posts];

        emit(
          state.copyWith(
            posts: updatedPosts,
            status: RequestStatus.success,
            hasReachedMax: posts.length < 10,
            pageNumber: pageNumber + 1,
          ),
        );
      },
    );
  }
}
