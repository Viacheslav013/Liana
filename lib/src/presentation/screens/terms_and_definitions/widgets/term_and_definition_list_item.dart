import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/presentation/common/platform_icon.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/themes/colors.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class TermAndDefinitionListItem extends StatelessWidget {
  const TermAndDefinitionListItem({
    required this.termAndDefinition,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onIsFavoritePressed,
    super.key,
  });

  final TermAndDefinition termAndDefinition;
  final void Function(TermAndDefinition) onEditPressed;
  final void Function(TermAndDefinition) onDeletePressed;
  final void Function(TermAndDefinition) onIsFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEditPressed(termAndDefinition),
            icon: Platform.isIOS ? CupertinoIcons.pen : Icons.edit,
            backgroundColor: editListItemActionColor,
            foregroundColor: listItemActionForeground,
          ),
          SlidableAction(
            onPressed: (_) => onDeletePressed(termAndDefinition),
            icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete_outline,
            backgroundColor: deleteListItemActionColor,
            foregroundColor: listItemActionForeground,
          ),
        ],
      ),
      child: PlatformListTile(
        title: Text(termAndDefinition.term),
        subtitle: Text(
          termAndDefinition.definition,
          overflow: TextOverflow.visible,
          maxLines: 10000,
          style: Platform.isIOS
              ? getCupertinoListSubtitleTextStyle(context)
              : null,
        ),
        trailing: GestureDetector(
          onTap: () => onIsFavoritePressed(termAndDefinition),
          child: PlatformIcon(
            color: favoriteColor,
            iosIcon: termAndDefinition.isFavorite
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart,
            materialIcon: termAndDefinition.isFavorite
                ? Icons.favorite
                : Icons.favorite_outline,
          ),
        ),
      ),
    );
  }
}
