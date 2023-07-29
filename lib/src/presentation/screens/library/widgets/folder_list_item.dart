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
    required this.onEditClick,
    required this.onDeletePressed,
    super.key,
  });

  final Folder folder;
  final void Function(Folder) onEditClick;
  final void Function(Folder) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEditClick(folder),
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
        title: Text(folder.name),
      ),
    );
  }
}
