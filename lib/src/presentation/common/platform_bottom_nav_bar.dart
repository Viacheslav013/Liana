import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class PlatformBottomNavBar {
  PlatformBottomNavBar({
    required List<BottomNavBarItem> items,
    required this.selectedItemIndex,
    required this.onItemTap,
  }) {
    cupertinoItems = items.map((e) => e._toCupertino()).toList();
    materialItems = items.map((e) => e._toMaterial()).toList();
  }

  late final List<BottomNavigationBarItem> cupertinoItems;
  late final List<NavigationDestination> materialItems;
  final int selectedItemIndex;
  final ValueChanged<int> onItemTap;

  CupertinoTabBar buildCupertinoWidget() {
    return CupertinoTabBar(
      items: cupertinoItems,
      onTap: onItemTap,
      currentIndex: selectedItemIndex,
      border: Border(
        top: BorderSide(
          color: tabBarBordersColor,
          width: 0,
        ),
      ),
    );
  }

  Widget buildMaterialWidget() {
    return NavigationBar(
      destinations: materialItems,
      onDestinationSelected: onItemTap,
      selectedIndex: selectedItemIndex,
      elevation: 0,
    );
  }
}

class BottomNavBarItem {
  const BottomNavBarItem({
    required this.cupertinoIcon,
    required this.materialIcon,
    required this.label,
  });

  final Widget cupertinoIcon;
  final Widget materialIcon;
  final String label;
  
  BottomNavigationBarItem _toCupertino() {
    return BottomNavigationBarItem(
      icon: cupertinoIcon,
      label: label,
    );
  }
  
  NavigationDestination _toMaterial() {
    return NavigationDestination(
      icon: materialIcon,
      label: label,
    );
  }
}
