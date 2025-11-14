import 'package:flutter/material.dart';
import 'package:mock_api/core/helper/number_extentions.dart';

import '../../../../core/helper/app_extention.dart';

class PostsErrorView extends StatelessWidget {
  const PostsErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: context.textStyles.font16BoldSecondaryColor.copyWith(
                color: context.colors.redColor,
              ),
              textAlign: TextAlign.center,
            ),
            16.verticalSizedBox,
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
