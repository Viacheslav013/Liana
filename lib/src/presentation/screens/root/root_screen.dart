import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_bottom_nav_bar.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/screens/favorites/favorites_screen.dart';
import 'package:liana/src/presentation/screens/library/library_screen.dart';
import 'package:liana/src/presentation/screens/settings/settings_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return RootScreenState();
  }
}

class RootScreenState extends State<RootScreen> {
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  int _selectedItemIndex = 0;

  List<bool> _getOffstagesForRootScreens() {
    return [
      0 != _selectedItemIndex,
      1 != _selectedItemIndex,
      2 != _selectedItemIndex,
    ];
  }

  List<Widget> _getRootBottomNavBarWidgets() {
    return const [
      LibraryScreen(),
      FavoritesScreen(),
      SettingsScreen(),
    ];
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      bottomNavBarNavigatorKeys: _navigatorKeys,
      currentBottomNavBarNavigatorKey: _navigatorKeys[_selectedItemIndex],
      body: _getRootBottomNavBarWidgets()[_selectedItemIndex],
      offstagesForRootScreens: _getOffstagesForRootScreens(),
      rootBottomNavBarWidgets: _getRootBottomNavBarWidgets(),
      bottomNavBar: PlatformBottomNavBar(
        onItemTap: _onItemTap,
        selectedItemIndex: _selectedItemIndex,
        items: [
          BottomNavBarItem(
            cupertinoIcon: const Icon(CupertinoIcons.folder),
            materialIcon: const Icon(Icons.folder_outlined),
            label: 'library_screen_title'.tr(),
          ),
          BottomNavBarItem(
            cupertinoIcon: const Icon(CupertinoIcons.heart),
            materialIcon: const Icon(Icons.favorite_outline),
            label: 'favorites_screen_title'.tr(),
          ),
          BottomNavBarItem(
            cupertinoIcon: const Icon(CupertinoIcons.settings),
            materialIcon: const Icon(Icons.settings_outlined),
            label: 'settings_screen_title'.tr(),
          ),
        ],
      ),
    );
  }
}
