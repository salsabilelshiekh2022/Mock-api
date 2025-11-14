import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_api/core/components/widgets/app_snack_bar.dart';
import 'package:mock_api/core/helper/number_extentions.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/use_cases/get_posts_use_case.dart';
import '../cubit/posts_cubit.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/post_card.dart';
import '../widgets/posts_error_view.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit(getPostsUseCase: getIt<GetPostsUseCase>()),
      child: const _PostsViewBody(),
    );
  }
}

class _PostsViewBody extends StatefulWidget {
  const _PostsViewBody();

  @override
  State<_PostsViewBody> createState() => _PostsViewBodyState();
}

class _PostsViewBodyState extends State<_PostsViewBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<PostsCubit>().getPosts(pageNumber: 0);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final cubit = context.read<PostsCubit>();
    final state = cubit.state;
    if (state.status.isLoading ||
        state.status.isLoadingMore ||
        state.hasReachedMax) {
      return;
    }

    final position = _scrollController.position;
    if (position.userScrollDirection != ScrollDirection.reverse) {
      return;
    }
    if (position.extentAfter < 200) {
      cubit.getPosts(pageNumber: state.pageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocListener<PostsCubit, PostsState>(
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
        listener: (context, state) {
          if (state.status.isError) {
            AppSnackBar.showSnackBar(
              context: context,
              message: state.errorMessage!,
              state: SnackBarStates.error,
            );
          }
        },
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state.status.isLoading && state.posts.isEmpty) {
              return const LoadingIndicator();
            }

            if (state.status.isError && state.posts.isEmpty) {
              return PostsErrorView(
                message: state.errorMessage ?? 'Something went wrong',
                onRetry: () =>
                    context.read<PostsCubit>().getPosts(pageNumber: 0),
              );
            }

            return ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: 16.allPadding,
              itemBuilder: (context, index) {
                if (index >= state.posts.length) {
                  if (state.status.isLoadingMore) {
                    return const LoadingIndicator();
                  }
                  return const SizedBox.shrink();
                }
                return PostCard(post: state.posts[index]);
              },
              separatorBuilder: (_, __) => 12.verticalSizedBox,
              itemCount: state.posts.length + (state.hasReachedMax ? 0 : 1),
            );
          },
        ),
      ),
    );
  }
}
