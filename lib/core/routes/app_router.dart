import 'package:flutter/material.dart';
import '../../features/posts/presentation/views/posts_view.dart';
import '../../features/splash/presentations/views/splash_view.dart';
import 'routes.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.postsView:
        return MaterialPageRoute(builder: (_) => const PostsView());
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      default:
        return MaterialPageRoute(builder: (_) => const PostsView());
    }
  }
}
