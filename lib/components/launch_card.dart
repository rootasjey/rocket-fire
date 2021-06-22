import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rocketfire/types/launch.dart';
import 'package:rocketfire/utils/fonts.dart';

class LaunchCard extends StatefulWidget {
  final double width;
  final double height;

  final Launch launch;
  final Function()? onTap;

  const LaunchCard({
    Key? key,
    required this.launch,
    this.onTap,
    this.width = 300.0,
    this.height = 130.0,
  }) : super(key: key);

  @override
  _LaunchCardState createState() => _LaunchCardState();
}

class _LaunchCardState extends State<LaunchCard> {
  double _elevation = 0.0;
  double _borderWidth = 2.0;
  Color _borderColor = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    final launch = widget.launch;

    return Card(
      elevation: _elevation,
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: _borderColor,
          width: _borderWidth,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (isHover) {
          if (isHover) {
            setState(() {
              _elevation = 2.0;
              _borderColor = Colors.pink;
              _borderWidth = 3.0;
            });

            return;
          }

          setState(() {
            _elevation = 0.0;
            _borderColor = Colors.blue.shade700;
            _borderWidth = 2.0;
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height,
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
