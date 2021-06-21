import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rocketfire/types/launch.dart';
import 'package:rocketfire/utils/fonts.dart';

class LaunchCard extends StatefulWidget {
  final Launch launch;

  const LaunchCard({Key? key, required this.launch}) : super(key: key);

  @override
  _LaunchCardState createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
  double _elevation = 0.0;
  Color _borderColor = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    final launch = widget.launch;

    return Card(
      elevation: _elevation,
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(color: _borderColor, width: 2.0),
      ),
      child: InkWell(
        onTap: () {},
        onHover: (isHover) {
          if (isHover) {
            setState(() {
              _elevation = 2.0;
              _borderColor = Colors.pink;
            });

            return;
          }

          setState(() {
            _elevation = 0.0;
            _borderColor = Colors.blue.shade700;
          });
        },
        child: Container(
          width: 300.0,
          height: 130.0,
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.8,
                child: Text(
                  launch.missionName.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FontsUtils.mainStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.4,
                child: Text(
                  Jiffy(launch.launchDateLocal).yMMMMEEEEd,
                  style: FontsUtils.mainStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
