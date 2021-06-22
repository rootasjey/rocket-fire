import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:rocketfire/components/footer.dart';
import 'package:rocketfire/components/launch_card.dart';
import 'package:rocketfire/components/main_app_bar.dart';
import 'package:rocketfire/router/app_router.gr.dart';
import 'package:rocketfire/state/colors.dart';
import 'package:rocketfire/types/launch.dart';
import 'package:rocketfire/utils/app_graphql.dart';
import 'package:rocketfire/utils/app_logger.dart';
import 'package:rocketfire/utils/fonts.dart';
import 'package:rocketfire/utils/graphql_queries.dart';
import 'package:unicons/unicons.dart';

class LaunchesPage extends StatefulWidget {
  const LaunchesPage({Key? key}) : super(key: key);

  @override
  _LaunchesPageState createState() => _LaunchesPageState();
}

class _LaunchesPageState extends State<LaunchesPage> {
  bool _isLoading = false;
  List<Launch> _launches = [];

  int _limit = 10;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          title(),
          body(),
          footer(),
        ],
      ),
    );
  }

  Widget body() {
    if (_isLoading) {
      return loadingView();
    }

    if (_launches.isEmpty) {
      return errorView();
    }

    return idleView();
  }

  Widget footer() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 100.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Footer(),
        ]),
      ),
    );
  }

  Widget loadingView() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Center(
          child: Text(
            "Loading...",
            style: FontsUtils.mainStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ]),
    );
  }

  Widget errorView() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Center(
          child: Text(
            "Sorry, we couldn't retrieve data. Please try later.",
            style: FontsUtils.mainStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ]),
    );
  }

  Widget idleView() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final launch = _launches.elementAt(index);

            return LaunchCard(
              height: 50.0,
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
          },
          childCount: _launches.length,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 150.0,
          maxCrossAxisExtent: 340.0,
          childAspectRatio: 1.5,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
      ),
    );
  }

  Widget title() {
    return SliverPadding(
      padding: const EdgeInsets.all(80.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 1.0,
                child: IconButton(
                  color: stateColors.secondary,
                  onPressed: context.router.pop,
                  icon: Icon(UniconsLine.arrow_left),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                ),
                child: Text(
                  "Latest launches",
                  style: FontsUtils.mainStyle(
                    fontSize: 70.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ]),
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
        'offset': _offset,
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
