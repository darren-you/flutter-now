import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutternow/managers/protocol_manager.dart';
import 'package:flutternow/modules/home/ui/home_page.dart';
import 'package:flutternow/modules/login/login.dart';
import 'package:flutternow/modules/setting/ui/setting_page.dart';
import 'package:flutternow/providers/app_user_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutternow/modules/protocols/ui/app_protocol_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'modules/user_profile/ui/user_profile_page.dart';

part 'router.g.dart';

/// 自定义路由观察者
final routeObserver = RouteObserver<PageRoute>();

/// App隐私协议
@TypedGoRoute<AppProtocolRoute>(path: '/appprotocol')
class AppProtocolRoute extends GoRouteData {
  const AppProtocolRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(child: AppProtocolPage());
  }
}

/// 首页
@TypedGoRoute<MainRoute>(
  path: '/home/:tab',
)
class MainRoute extends GoRouteData {
  const MainRoute({required this.tab});

  final String tab;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoPage(
      child: HomePage(
        initialTab: HomePageTab.fromString(tab),
      ),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (!ProtocolManager.instance.agreedAppProtocolStatus()) {
      return AppProtocolRoute().location;
    }
    return null;
  }
}

/// 账号密码登录页
@TypedGoRoute<AccoutLoginRoute>(path: '/accout')
class AccoutLoginRoute extends GoRouteData {
  const AccoutLoginRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(
      child: AccountLoginPage(),
      fullscreenDialog: true,
    );
  }
}

/// 用户资料页
@TypedGoRoute<UserProfileRoute>(path: '/profile')
class UserProfileRoute extends GoRouteData {
  const UserProfileRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(
      child: UserProfilePage(),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (!ProviderContainer().read(isLoggedProvider)) {
      return AccoutLoginRoute().location;
    }
    return null;
  }
}

/// 设置页
@TypedGoRoute<SettingRoute>(path: '/setting')
class SettingRoute extends GoRouteData {
  const SettingRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoPage(
      child: SettingPage(),
    );
  }
}
