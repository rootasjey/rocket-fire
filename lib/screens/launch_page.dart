import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rocketfire/components/main_app_bar.dart';
import 'package:rocketfire/state/colors.dart';
import 'package:rocketfire/types/launch.dart';
import 'package:rocketfire/utils/app_graphql.dart';
import 'package:rocketfire/utils/app_logger.dart';
import 'package:rocketfire/utils/fonts.dart';
import 'package:rocketfire/utils/graphql_queries.dart';
import 'package:unicons/unicons.dart';

class LaunchPage extends StatefulWidget {
  final String launchId;
  final Launch? launch;

  const LaunchPage({
    Key? key,
    @PathParam('launchId') required this.launchId,
    this.launch,
  }) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  bool _isLoading = false;
  Launch? _launch;

  @override
  void initState() {
    super.initState();

    if (widget.launch != null) {
      _launch = widget.launch;
      return;
    }

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    if (_isLoading) {
      return loadingView();
    }

    if (_launch == null) {
      return errorView();
    }

    return idleView();
  }

  Widget loadingView() {
    return Center(
      child: Text("Loading..."),
    );
  }

  Widget errorView() {
    return Text(
      "Sorry, an error ocurred while loading space data.",
    );
  }

  Widget idleView() {
    return SliverPadding(
      padding: const EdgeInsets.all(80.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.6,
                child: IconButton(
                  onPressed: context.router.pop,
                  icon: Icon(UniconsLine.arrow_left),
                ),
              ),
              SizedBox(
                width: 500.0,
                child: Text(
                  _launch!.missionName,
                  style: FontsUtils.mainStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.4,
                child: Text(
                  Jiffy(_launch!.launchDateLocal).yMMMMEEEEd,
                  style: FontsUtils.mainStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Wrap(
                  spacing: 24.0,
                  children: [
                    Icon(UniconsLine.rocket, color: stateColors.primary),
                    Text(
                      _launch!.rocket.name,
                      style: FontsUtils.mainStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
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
    });

    const int limit = 3;

    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getPastLaunches),
      variables: <String, dynamic>{
        'limit': limit,
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

      final Object? launchPast = queryResult.data!['launch'];

      final launchMapData = launchPast as dynamic;
      _launch = Launch.fromJSON(launchMapData);
    } catch (error) {
      appLogger.e(error);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
