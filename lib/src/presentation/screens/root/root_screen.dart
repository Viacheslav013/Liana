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
        items: const [
          BottomNavBarItem(
            cupertinoIcon: Icon(CupertinoIcons.folder),
            materialIcon: Icon(Icons.folder_outlined),
            label: 'Библиотека',
          ),
          BottomNavBarItem(
            cupertinoIcon: Icon(CupertinoIcons.heart),
            materialIcon: Icon(Icons.favorite_outline),
            label: 'Избранные',
          ),
          BottomNavBarItem(
            cupertinoIcon: Icon(CupertinoIcons.settings),
            materialIcon: Icon(Icons.settings_outlined),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}
