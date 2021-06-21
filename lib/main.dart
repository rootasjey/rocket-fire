import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocketfire/router/app_router.gr.dart';
import 'package:rocketfire/state/colors.dart';
import 'package:rocketfire/utils/fonts.dart';
import 'package:supercharged_dart/supercharged_dart.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setPathUrlStrategy();

  return runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [Locale('en'), Locale('fr')],
      fallbackLocale: Locale('en'),
      child: App(
        // savedThemeMode: savedThemeMode,
        savedThemeMode: AdaptiveThemeMode.dark,
        // brightness: brightness
        brightness: Brightness.dark,
      ),
    ),
  );
}

/// Main app class.
class App extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final Brightness? brightness;

  const App({
    Key? key,
    this.savedThemeMode,
    this.brightness,
  }) : super(key: key);

  AppState createState() => AppState();
}

/// Main app class state.
class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    stateColors.refreshTheme(widget.brightness);

    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        backgroundColor: stateColors.lightBackground,
        scaffoldBackgroundColor: stateColors.lightBackground,
        fontFamily: FontsUtils.fontFamily,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        fontFamily: FontsUtils.fontFamily,
        scaffoldBackgroundColor: Colors.black,
      ),
      initial: AdaptiveThemeMode.dark,
      // initial: widget.brightness == Brightness.light
      //     ? AdaptiveThemeMode.light
      //     : AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) {
        stateColors.themeData = theme;

        return AppWithTheme(
          brightness: widget.brightness,
          theme: theme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}

/// Because we need a [context] with adaptive theme data available in it.
class AppWithTheme extends StatefulWidget {
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final Brightness? brightness;

  const AppWithTheme({
    Key? key,
    @required this.brightness,
    @required this.darkTheme,
    @required this.theme,
  }) : super(key: key);

  @override
  _AppWithThemeState createState() => _AppWithThemeState();
}

class _AppWithThemeState extends State<AppWithTheme> {
  final appRouter = AppRouter();

  @override
  initState() {
    super.initState();
    Future.delayed(250.milliseconds, () {
      AdaptiveTheme.of(context).setDark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'rocket fire',
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
