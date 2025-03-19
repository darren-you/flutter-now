// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appProtocolRoute,
      $mainRoute,
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
      path: '/home',
      factory: $MainRouteExtension._fromState,
    );

extension $MainRouteExtension on MainRoute {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
