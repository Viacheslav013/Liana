import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_bottom_nav_bar.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';
import 'package:liana/src/utils/iterable_extensions.dart';

class PlatformScaffold extends PlatformWidget {
  const PlatformScaffold({
    required this.body,
    this.topAppBar,
    this.bottomNavBar,
    this.floatingActionButton,
    this.bottomNavBarNavigatorKeys,
    this.currentBottomNavBarNavigatorKey,
    this.offstagesForRootScreens,
    this.rootBottomNavBarWidgets,
    super.key,
  });

  final PreferredSizeWidget? topAppBar;
  final Widget body;
  final PlatformBottomNavBar? bottomNavBar;
  final FloatingActionButton? floatingActionButton;
  final List<GlobalKey<NavigatorState>>? bottomNavBarNavigatorKeys;
  final GlobalKey<NavigatorState>? currentBottomNavBarNavigatorKey;
  final List<bool>? offstagesForRootScreens;
  final List<Widget>? rootBottomNavBarWidgets;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    final localBottomNavBar = bottomNavBar;

    if (localBottomNavBar != null) {
      return CupertinoTabScaffold(
        tabBar: localBottomNavBar.buildCupertinoWidget(),
        tabBuilder: (_, __) => CupertinoTabView(
          builder: (_) => body,
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: topAppBar as ObstructingPreferredSizeWidget?,
      child: body,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    final localBottomNavBar = bottomNavBar;

    if (localBottomNavBar != null) {
      return WillPopScope(
        onWillPop: () async => !(await currentBottomNavBarNavigatorKey
          ?.currentState?.maybePop() ?? false),
        child: Scaffold(
          appBar: topAppBar,
          body: Stack(
            children: offstagesForRootScreens?.mapIndexed((offstage, index) =>
              Offstage(
                offstage: offstage,
                child: Navigator(
                  key: bottomNavBarNavigatorKeys?[index],
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
                    builder: (_) =>
                      rootBottomNavBarWidgets?[index] ?? Container(),
                  ),
                ),
              ),
            ).toList() ?? [],
          ),
          bottomNavigationBar: localBottomNavBar.buildMaterialWidget(),
          floatingActionButton: floatingActionButton,
        ),
      );
    }

    return Scaffold(
      appBar: topAppBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
