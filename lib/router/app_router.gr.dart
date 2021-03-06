// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screens/about_page.dart' as _i4;
import '../screens/contact_page.dart' as _i7;
import '../screens/home_page.dart' as _i3;
import '../screens/launch_page.dart' as _i5;
import '../screens/launches_page.dart' as _i6;
import '../screens/tos.dart' as _i8;
import '../screens/undefined_page.dart' as _i9;
import '../types/launch.dart' as _i10;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomePage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    AboutPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.AboutPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    LaunchPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<LaunchPageRouteArgs>(
              orElse: () => LaunchPageRouteArgs(
                  launchId: pathParams.getString('launchId')));
          return _i5.LaunchPage(
              key: args.key, launchId: args.launchId, launch: args.launch);
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    LaunchesPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.LaunchesPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    ContactPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.ContactPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    TosPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.TosPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false),
    UndefinedPageRoute.name: (routeData) => _i1.CustomPage<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.UndefinedPage();
        },
        transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false)
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomePageRoute.name, path: '/'),
        _i1.RouteConfig(AboutPageRoute.name, path: '/about'),
        _i1.RouteConfig(LaunchPageRoute.name, path: '/launch/:launchId'),
        _i1.RouteConfig(LaunchesPageRoute.name, path: '/launches'),
        _i1.RouteConfig(ContactPageRoute.name, path: '/contact'),
        _i1.RouteConfig(TosPageRoute.name, path: '/tos'),
        _i1.RouteConfig(UndefinedPageRoute.name, path: '*')
      ];
}

class HomePageRoute extends _i1.PageRouteInfo {
  const HomePageRoute() : super(name, path: '/');

  static const String name = 'HomePageRoute';
}

class AboutPageRoute extends _i1.PageRouteInfo {
  const AboutPageRoute() : super(name, path: '/about');

  static const String name = 'AboutPageRoute';
}

class LaunchPageRoute extends _i1.PageRouteInfo<LaunchPageRouteArgs> {
  LaunchPageRoute({_i2.Key? key, required String launchId, _i10.Launch? launch})
      : super(name,
            path: '/launch/:launchId',
            args: LaunchPageRouteArgs(
                key: key, launchId: launchId, launch: launch),
            rawPathParams: {'launchId': launchId});

  static const String name = 'LaunchPageRoute';
}

class LaunchPageRouteArgs {
  const LaunchPageRouteArgs({this.key, required this.launchId, this.launch});

  final _i2.Key? key;

  final String launchId;

  final _i10.Launch? launch;
}

class LaunchesPageRoute extends _i1.PageRouteInfo {
  const LaunchesPageRoute() : super(name, path: '/launches');

  static const String name = 'LaunchesPageRoute';
}

class ContactPageRoute extends _i1.PageRouteInfo {
  const ContactPageRoute() : super(name, path: '/contact');

  static const String name = 'ContactPageRoute';
}

class TosPageRoute extends _i1.PageRouteInfo {
  const TosPageRoute() : super(name, path: '/tos');

  static const String name = 'TosPageRoute';
}

class UndefinedPageRoute extends _i1.PageRouteInfo {
  const UndefinedPageRoute() : super(name, path: '*');

  static const String name = 'UndefinedPageRoute';
}
