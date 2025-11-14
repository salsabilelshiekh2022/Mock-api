import 'package:mock_api/core/helper/app_extention.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasBackIcon = false,
  });
  final String title;
  final bool hasBackIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primaryColor,
      title: Text(title, style: context.textStyles.font18SemiBoldWhiteColor),
      leading: hasBackIcon
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back, color: context.colors.whiteColor),
            )
          : const SizedBox(),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
