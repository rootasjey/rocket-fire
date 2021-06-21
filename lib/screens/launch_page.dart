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
import 'package:supercharged/supercharged.dart';
import 'package:unicons/unicons.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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

  YoutubePlayerController? _ytController;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.launch != null) {
      _launch = widget.launch;
      initVideoPlayer();
      return;
    }

    fetch();
  }

  @override
  void dispose() {
    _ytController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab(),
      body: CustomScrollView(
        controller: _scrollController,
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

  Widget errorView() {
    return Text(
      "Sorry, an error ocurred while loading space data.",
    );
  }

  Widget fab() {
    return FloatingActionButton.extended(
      onPressed: () {
        _scrollController.animateTo(
          0.0,
          duration: 250.milliseconds,
          curve: Curves.decelerate,
        );
      },
      label: Text(
        "scroll to top",
        style: FontsUtils.mainStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
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
              videoWidget(),
            ],
          ),
        ]),
      ),
    );
  }

  Widget loadingView() {
    return Center(
      child: Text("Loading..."),
    );
  }

  Widget videoWidget() {
    if (_ytController == null) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(top: 70.0, bottom: 100.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: YoutubePlayerIFrame(
        controller: _ytController,
        aspectRatio: 16 / 9,
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

      initVideoPlayer();
    } catch (error) {
      appLogger.e(error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void initVideoPlayer() async {
    final videoStr = _launch!.links.video;
    final videoId = videoStr.substring(videoStr.lastIndexOf('/') + 1);

    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }
}
