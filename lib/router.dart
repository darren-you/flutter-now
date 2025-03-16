import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutternow/splash.dart';

part 'router.g.dart';

/// 自定义路由观察者
final routeObserver = RouteObserver<PageRoute>();

/// 闪屏页
@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(child: SplashPage());
  }
}
