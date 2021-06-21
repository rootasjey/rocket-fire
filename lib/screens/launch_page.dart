import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  final String launchId;

  const LaunchPage({
    Key? key,
    @PathParam('launchId') required this.launchId,
  }) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
