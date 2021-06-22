import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:rocketfire/components/footer.dart';
import 'package:rocketfire/components/launch_card.dart';
import 'package:rocketfire/components/main_app_bar.dart';
import 'package:rocketfire/router/app_router.dart';
import 'package:rocketfire/state/colors.dart';
import 'package:rocketfire/types/launch.dart';
import 'package:rocketfire/utils/app_graphql.dart';
import 'package:rocketfire/utils/app_logger.dart';
import 'package:rocketfire/utils/constants.dart';
import 'package:rocketfire/utils/fonts.dart';
import 'package:rocketfire/utils/graphql_queries.dart';
import 'package:supercharged/supercharged.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  final _launches = <Launch>[];

  final int _limit = 3;

  final _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          MainAppBar(),
          body(),
          footer(),
        ],
      ),
    );
  }

  Widget body() {
    return idleView();
  }

  Widget footer() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Footer(),
      ]),
    );
  }

  Widget loadingView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Text("Loading...",
          style: FontsUtils.mainStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w600,
          )),
    );
  }

  Widget idleView() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        heroContainer(),
        latestLaunchContainer(),
      ]),
    );
  }

  Widget heroContainer() {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    final showRocketIcon = pageWidth > 600.0;

    return Container(
      height: pageHeight,
      width: pageWidth,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              "assets/images/earth_by_actionvance.jpg",
              height: pageHeight,
              width: pageWidth,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heroTexts(),
              if (showRocketIcon)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 80.0,
                    bottom: 80.0,
                  ),
                  child: Opacity(
                    opacity: 0.8,
                    child: Icon(
                      UniconsLine.rocket,
                      size: 120.0,
                    ),
                  ),
                ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 80.0,
            child: IconButton(
              onPressed: () {
                final double offset = MediaQuery.of(context).size.height;
                _scrollController.animateTo(
                  offset,
                  duration: 500.milliseconds,
                  curve: Curves.decelerate,
                );
              },
              icon: Icon(UniconsLine.arrow_down),
            ),
          ),
        ],
      ),
    );
  }

  Widget heroTexts() {
    final double pageWidth = MediaQuery.of(context).size.width;
    double width = 600.0;
    EdgeInsets padding = const EdgeInsets.all(80.0);

    if (pageWidth < Constants.maxMobileWidth) {
      width = pageWidth;
      padding = const EdgeInsets.only(left: 24.0, right: 24.0, top: 42.0);
    }

    return Container(
      width: width,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rocket \nLaunch",
            style: FontsUtils.mainStyle(
              fontSize: 80.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Text(
              "Get latest information on SpaceX",
              style: FontsUtils.mainStyle(
                // fontSize: 80.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text.rich(
              TextSpan(
                text: "This is a handcrafted Flutter app using",
                children: [
                  TextSpan(
                    text: " SpaceX GraphQL API.",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch("https://api.spacex.land");
                      },
                    style: FontsUtils.mainStyle(
                      color: stateColors.secondary,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: " Feel free to scroll down and explore.",
                  ),
                ],
              ),
              style: FontsUtils.mainStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Colors.white60,
                backgroundColor: Colors.black12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget latestLaunchContainer() {
    if (_isLoading) {
      return loadingView();
    }

    final double pageWidth = MediaQuery.of(context).size.width;
    EdgeInsets padding = const EdgeInsets.all(80.0);
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;

    if (pageWidth < Constants.maxMobileWidth) {
      padding = const EdgeInsets.only(left: 24.0, right: 24.0, top: 42.0);
      crossAxisAlignment = CrossAxisAlignment.center;
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 42.0),
            child: Text(
              "Latest launches",
              style: FontsUtils.mainStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Wrap(
            spacing: 24.0,
            runSpacing: 24.0,
            children: _launches.map((launch) {
              return LaunchCard(
                launch: launch,
                onTap: () {
                  context.router.push(
                    LaunchPageRoute(
                      launchId: launch.id,
                      launch: launch,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void fetch() async {
    setState(() {
      _isLoading = true;
      _launches.clear();
    });

    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getPastLaunches),
      variables: <String, dynamic>{
        'limit': _limit,
        'offset': 0,
      },
    );

    try {
      final QueryResult queryResult = await appGraphQL.client.query(options);

      if (queryResult.hasException) {
        appGraphQL.handleGraphQLException(queryResult.exception);
        return;
      }

      if (queryResult.data == null) {
        return;
      }

      final List<Object?> launchesPast = queryResult.data!['launchesPast'];

      for (var launchPast in launchesPast) {
        final launchMapData = launchPast as dynamic;
        final launch = Launch.fromJSON(launchMapData);
        _launches.add(launch);
      }
    } catch (error) {
      appLogger.e(error);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
