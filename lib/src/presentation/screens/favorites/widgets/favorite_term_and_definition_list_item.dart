import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/presentation/common/platform_icon.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/themes/colors.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class FavoriteTermAndDefinitionListItem extends StatelessWidget {
  const FavoriteTermAndDefinitionListItem({
    required this.termAndDefinition,
    required this.onIsFavoritePressed,
    super.key,
  });

  final TermAndDefinition termAndDefinition;
  final void Function(TermAndDefinition) onIsFavoritePressed;

  @override
  Widget build(BuildContext context) {
    return PlatformListTile(
      title: Text(termAndDefinition.term, maxLines: 10000),
      subtitle: Text(
        termAndDefinition.definition,
        overflow: TextOverflow.visible,
        maxLines: 10000,
        style:
            Platform.isIOS ? getCupertinoListSubtitleTextStyle(context) : null,
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
    );
  }
}
