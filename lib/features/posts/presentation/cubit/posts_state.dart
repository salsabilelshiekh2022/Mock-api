part of 'posts_cubit.dart';

class PostsState extends Equatable {
  final List<PostEntity> posts;
  final RequestStatus status;
  final String? errorMessage;
  final bool hasReachedMax;
  final int pageNumber;

  const PostsState({
    this.posts = const [],
    this.status = RequestStatus.initial,
    this.errorMessage,
    this.hasReachedMax = false,
    this.pageNumber = 0,
  });

  PostsState copyWith({
    List<PostEntity>? posts,
    RequestStatus? status,
    String? errorMessage,
    bool? hasReachedMax,
    int? pageNumber,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      errorMessage: errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    status,
    errorMessage,
    hasReachedMax,
    pageNumber,
  ];
}
