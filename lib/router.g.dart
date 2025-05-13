// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appProtocolRoute,
      $mainRoute,
      $accoutLoginRoute,
      $userProfileRoute,
      $settingRoute,
      $tesRoute,
    ];

RouteBase get $appProtocolRoute => GoRouteData.$route(
      path: '/appprotocol',
      factory: $AppProtocolRouteExtension._fromState,
    );

extension $AppProtocolRouteExtension on AppProtocolRoute {
  static AppProtocolRoute _fromState(GoRouterState state) =>
      const AppProtocolRoute();

  String get location => GoRouteData.$location(
        '/appprotocol',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainRoute => GoRouteData.$route(
      path: '/home/:tab',
      factory: $MainRouteExtension._fromState,
    );

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => MainRoute(
        tab: state.pathParameters['tab']!,
      );

  String get location => GoRouteData.$location(
        '/home/${Uri.encodeComponent(tab)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $accoutLoginRoute => GoRouteData.$route(
      path: '/accout',
      factory: $AccoutLoginRouteExtension._fromState,
    );

extension $AccoutLoginRouteExtension on AccoutLoginRoute {
  static AccoutLoginRoute _fromState(GoRouterState state) =>
      const AccoutLoginRoute();

  String get location => GoRouteData.$location(
        '/accout',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userProfileRoute => GoRouteData.$route(
      path: '/profile',
      factory: $UserProfileRouteExtension._fromState,
    );

extension $UserProfileRouteExtension on UserProfileRoute {
  static UserProfileRoute _fromState(GoRouterState state) =>
      const UserProfileRoute();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingRoute => GoRouteData.$route(
      path: '/setting',
      factory: $SettingRouteExtension._fromState,
    );

extension $SettingRouteExtension on SettingRoute {
  static SettingRoute _fromState(GoRouterState state) => const SettingRoute();

  String get location => GoRouteData.$location(
        '/setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $tesRoute => GoRouteData.$route(
      path: '/test',
      factory: $TesRouteExtension._fromState,
    );

extension $TesRouteExtension on TesRoute {
  static TesRoute _fromState(GoRouterState state) => const TesRoute();

  String get location => GoRouteData.$location(
        '/test',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
