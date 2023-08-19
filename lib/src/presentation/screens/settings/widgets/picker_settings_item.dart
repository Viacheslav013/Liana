import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_icon.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/common/show_platform_bottom_sheet.dart';
import 'package:liana/src/presentation/navigation/utils.dart';

class PickerSettingsItem<T> extends StatelessWidget {
  const PickerSettingsItem({
    required this.title,
    required this.pickerTitle,
    required this.value,
    required this.pickerItems,
    super.key,
  });

  final Widget title;
  final Widget pickerTitle;
  final Widget value;
  final List<PickerItem<T>> pickerItems;

  void _showPicker(BuildContext context) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      minHeight: MediaQuery.of(context).size.longestSide / 2,
      isScrollControlled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Platform.isIOS ? 20 : 16,
              top: Platform.isIOS ? 32 : 0,
            ),
            child: pickerTitle,
          ),
          const SizedBox(height: 6),
          for (final item in pickerItems)
            PlatformListTile(
              title: item.title,
              onTap: () => _onItemTap(context, item.onTap),
              trailing: item.selected
                  ? const PlatformIcon(
                      iosIcon: CupertinoIcons.checkmark_alt,
                      materialIcon: Icons.done,
                    )
                  : null,
            ),
        ],
      ),
    );
  }

  void _onItemTap(BuildContext context, VoidCallback onTap) {
    onTap();
    rootNavigator(context)?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformListTile(
      title: title,
      trailing: value,
      onTap: () => _showPicker(context),
    );
  }
}

class PickerItem<T> {
  const PickerItem({
    required this.title,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final Widget title;
  final bool selected;
  final T value;
  final VoidCallback onTap;
}
