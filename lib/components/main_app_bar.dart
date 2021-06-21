import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rocketfire/components/app_icon.dart';
import 'package:rocketfire/components/underlined_button.dart';
import 'package:rocketfire/router/app_router.gr.dart';
import 'package:rocketfire/state/colors.dart';
import 'package:rocketfire/utils/constants.dart';
import 'package:rocketfire/utils/fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAppBar extends StatefulWidget {
  final bool renderSliver;

  const MainAppBar({
    Key? key,
    this.renderSliver = true,
  }) : super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final isNarrow = pageWidth < Constants.maxMobileWidth;

    final padding = EdgeInsets.only(
      left: isNarrow ? 0.0 : 80.0,
    );

    if (widget.renderSliver) {
      return renderSliver(
        isNarrow: isNarrow,
        padding: padding,
      );
    }

    return renderBox(
      isNarrow: isNarrow,
      padding: padding,
    );
  }

  Widget addButton() {
    return IconButton(
      tooltip: "upload".tr(),
      onPressed: () {},
      icon: Icon(
        UniconsLine.plus,
        color: stateColors.foreground.withOpacity(0.6),
      ),
    );
  }

  Widget desktopSectionsRow() {
    return Wrap(
      spacing: 12.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        sectionButton(
          // onPressed: () => context.router.root.push(IllustrationsRouter()),
          text: "launches".tr(),
        ),
        sectionButton(
          // onPressed: () => context.router.root.push(IllustrationsRouter()),
          text: "about".tr(),
        ),
        sectionButton(
          onPressed: () => launch(Constants.appGithubUrl),
          text: "GitHub",
        ),
        IconButton(
          onPressed: () {
            // context.router.root.push(SearchPageRoute());
          },
          color: stateColors.foreground.withOpacity(0.8),
          icon: Icon(UniconsLine.search),
        ),
      ],
    );
  }

  Widget mobileSectionsRow() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: sectionsPopupMenu(),
        ),
        IconButton(
          tooltip: "search".tr(),
          onPressed: () {
            // context.router.root.push(SearchPageRoute());
          },
          color: stateColors.foreground.withOpacity(0.8),
          icon: Icon(UniconsLine.search),
        ),
      ],
    );
  }

  Widget renderBox({
    bool isNarrow = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return AppBar(
      backgroundColor: stateColors.lightBackground,
      title: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AppIcon(),
            sectionsRow(isNarrow),
          ],
        ),
      ),
    );
  }

  Widget renderSliver({
    required bool isNarrow,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      // backgroundColor: stateColors.lightBackground,
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AppIcon(size: 32.0),
            sectionsRow(isNarrow),
          ],
        ),
      ),
    );
  }

  Widget searchButton() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 8.0,
      ),
      child: Opacity(
        opacity: 0.6,
        child: IconButton(
          tooltip: "search".tr(),
          onPressed: () {
            // context.router.root.push(SearchPageRoute());
          },
          color: stateColors.foreground,
          icon: Icon(UniconsLine.search),
        ),
      ),
    );
  }

  Widget sectionButton({
    VoidCallback? onPressed,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: UnderlinedButton(
        onTap: onPressed,
        child: Opacity(
          opacity: 0.8,
          child: Text(
            text.toUpperCase(),
            style: FontsUtils.mainStyle(
              color: stateColors.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionsPopupMenu() {
    return PopupMenuButton(
      child: Text(
        "sections".toUpperCase(),
        style: FontsUtils.mainStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
      itemBuilder: (context) => <PopupMenuItem<PageRouteInfo>>[
        PopupMenuItem(
          value: LaunchesPageRoute(),
          child: ListTile(
            leading: Icon(UniconsLine.image),
            title: Text("launches".tr()),
          ),
        ),
        PopupMenuItem(
          value: AboutPageRoute(),
          child: ListTile(
            leading: Icon(UniconsLine.apps),
            title: Text("about".tr()),
          ),
        ),
      ],
      onSelected: (PageRouteInfo pageRouteInfo) {
        context.router.root.push(pageRouteInfo);
      },
    );
  }

  Widget sectionsRow(bool isNarrow) {
    if (isNarrow) {
      return mobileSectionsRow();
    }

    return desktopSectionsRow();
  }
}
