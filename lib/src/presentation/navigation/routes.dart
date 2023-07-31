import 'package:flutter/cupertino.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/modules/cubit/modules_screen_cubit.dart';
import 'package:liana/src/presentation/screens/modules/modules_screen.dart';

PageRoute createModulesScreenRoute(
    Folder folder,
    [
      String? previousPageTitle,
    ]
) =>
  cubitScreen<ModulesScreenCubit>(
    ModulesScreenContent(folder: folder, previousPageTitle: previousPageTitle),
    onCreate: (cubit) => cubit.onCreate(folder),
  );
