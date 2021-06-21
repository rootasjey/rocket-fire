import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget imagesCredits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            launch("https://unsplash.com/s/photos/space"
                "?utm_source=unsplash&utm_medium=referral"
                "&utm_content=creditCopyText");
          },
          child: Text(
            "Photo by SpaceX on Unsplash",
          ),
        ),
        TextButton(
          onPressed: () {
            launch("https://unsplash.com/@spacex"
                "?utm_source=unsplash&utm_medium=referral"
                "&utm_content=creditCopyText");
          },
          child: Text(
            "Photo by SpaceX on Unsplash",
          ),
        ),
        TextButton(
          onPressed: () {
            launch("https://unsplash.com/@actionvance"
                "?utm_source=unsplash&utm_medium=referral"
                "&utm_content=creditCopyText");
          },
          child: Text(
            "Photo by ActionVance on Unsplash",
          ),
        ),
        TextButton(
          onPressed: () {
            launch("https://icons8.com/icon/65319/launch");
          },
          child: Text(
            "Launch icon by Icons8",
          ),
        ),
      ],
    );
  }
}
