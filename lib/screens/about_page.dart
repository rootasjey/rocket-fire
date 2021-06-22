import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rocketfire/components/footer.dart';
import 'package:rocketfire/components/main_app_bar.dart';
import 'package:rocketfire/utils/fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  final double paddingValue = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          title(context),
          description(),
          stack(),
          footer(),
        ],
      ),
    );
  }

  Widget creditButton({
    required String url,
    required String label,
    required Widget icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: OutlinedButton.icon(
        onPressed: () => launch(url),
        label: Text(
          label,
          style: FontsUtils.mainStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: icon,
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          padding: const EdgeInsets.all(24.0),
        ),
      ),
    );
  }

  Widget description() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: paddingValue),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 600.0,
                child: Opacity(
                  opacity: 0.6,
                  child: Text(
                    "This is a demo project showcasing Flutter & "
                    "GraphQL API consumption. "
                    "This project is under Mozilla Public License 2.0. "
                    "Contact me if you've any question.",
                    style: FontsUtils.mainStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: OutlinedButton(
                  onPressed: () => launch("mailto:jeremie@rootasjey.dev"),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Email me",
                      style: FontsUtils.mainStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget footer() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Footer(),
      ]),
    );
  }

  Widget stack() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: paddingValue),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60.0,
                  bottom: 12.0,
                ),
                child: Text(
                  "Tech Stack",
                  style: FontsUtils.mainStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              creditButton(
                url: "https://flutter.dev",
                label: "Flutter",
                icon: Icon(UniconsLine.arrow_right),
              ),
              creditButton(
                url: "https://api.spacex.land/graphql/",
                label: "SpaceX GraphQL API (unofficial)",
                icon: Icon(UniconsLine.arrow_right),
              ),
              creditButton(
                url: "https://iconscout.com",
                label: "Iconscout",
                icon: Icon(UniconsLine.arrow_right),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget title(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: paddingValue,
        right: paddingValue,
        top: paddingValue,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: context.router.pop,
                icon: Icon(UniconsLine.arrow_left),
              ),
              Container(
                child: Text(
                  "About",
                  style: FontsUtils.mainStyle(
                    fontSize: 90.0,
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
}
