import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/presentation/common/platform_icon.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/themes/colors.dart';

class FolderListItem extends StatelessWidget {
  const FolderListItem({
    required this.folder,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onTap,
    super.key,
  });

  final Folder folder;
  final void Function(Folder) onEditPressed;
  final void Function(Folder) onDeletePressed;
  final void Function(Folder) onTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEditPressed(folder),
            icon: Platform.isIOS ? CupertinoIcons.pen : Icons.edit,
            backgroundColor: editListItemActionColor,
            foregroundColor: listItemActionForeground,
          ),
          SlidableAction(
            onPressed: (_) => onDeletePressed(folder),
            icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete_outline,
            backgroundColor: deleteListItemActionColor,
            foregroundColor: listItemActionForeground,
          ),
        ],
      ),
      child: PlatformListTile(
        leading: const PlatformIcon(
          iosIcon: CupertinoIcons.folder,
          materialIcon: Icons.folder_outlined,
        ),
        onTap: () => onTap(folder),
        title: Text(folder.name, maxLines: 10000),
      ),
    );
  }
}
