import 'package:mock_api/core/helper/app_extention.dart';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) {
        // context.pushNamedAndRemoveUntil(Routes.authView);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash View',
          style: context.textStyles.font22BoldPrimaryColor,
        ),
      ),
    );
  }
}
