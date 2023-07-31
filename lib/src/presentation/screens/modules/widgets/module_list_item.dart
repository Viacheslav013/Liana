import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/presentation/common/platform_icon.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/themes/colors.dart';

class ModuleListItem extends StatelessWidget {
  const ModuleListItem({
    required this.module,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onTap,
    super.key,
  });

  final Module module;
  final void Function(Module) onEditPressed;
  final void Function(Module) onDeletePressed;
  final void Function(Module) onTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEditPressed(module),
            icon: Platform.isIOS ? CupertinoIcons.pen : Icons.edit,
            backgroundColor: editListItemActionColor,
            foregroundColor: listItemActionForeground,
          ),
          SlidableAction(
            onPressed: (_) => onDeletePressed(module),
            icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete_outline,
            backgroundColor: deleteListItemActionColor,
            foregroundColor: listItemActionForeground,
          ),
        ],
      ),
      child: PlatformListTile(
        onTap: () => onTap(module),
        title: Row(
          children: [
            const PlatformIcon(
              iosIcon: CupertinoIcons.folder,
              materialIcon: Icons.folder_outlined,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(module.name),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text('${module.numberOfDefinitions} терминов'),
        ),
      ),
    );
  }
}
