import 'package:flutter/material.dart';
import 'package:mock_api/core/helper/number_extentions.dart';

import '../../../../core/helper/app_extention.dart';
import '../../domain/entities/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({required this.post, super.key});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: context.colors.whiteColor,
        elevation: 1,
        borderRadius: 12.allBorderRadius,
        child: Padding(
          padding: 12.allPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: context.textStyles.font18BoldSecondaryColor,
              ),
              8.verticalSizedBox,
              Text(post.body, style: context.textStyles.font14RegularGrayColor),
              12.verticalSizedBox,
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: post.tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        backgroundColor: context.colors.primaryColor.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    )
                    .toList(),
              ),
              12.verticalSizedBox,
              Row(
                children: [
                  const Icon(Icons.thumb_up_alt_outlined, size: 16),
                  4.horizontalSizedBox,
                  Text('${post.reactions.likes}'),
                  12.horizontalSizedBox,
                  const Icon(Icons.thumb_down_alt_outlined, size: 16),
                  4.horizontalSizedBox,
                  Text('${post.reactions.dislikes}'),
                  const Spacer(),
                  const Icon(Icons.remove_red_eye_outlined, size: 16),
                  4.horizontalSizedBox,
                  Text('${post.views}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
