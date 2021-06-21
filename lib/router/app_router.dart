import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rocketfire/screens/about_page.dart';
import 'package:rocketfire/screens/home_page.dart';
import 'package:rocketfire/screens/launch_page.dart';
import 'package:rocketfire/screens/launches_page.dart';

export 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: [
    CustomRoute(
      path: '/',
      page: HomePage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      path: '/about',
      page: AboutPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      path: '/launch/:launchId',
      page: LaunchPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      path: '/launches',
      page: LaunchesPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ],
)
class $AppRouter {}
