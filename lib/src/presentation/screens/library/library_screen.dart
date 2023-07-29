import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/base/cubit_host.dart';
import 'package:liana/src/presentation/screens/library/cubit/library_screen_cubit.dart';
import 'package:liana/src/presentation/screens/library/widgets/library_screen_content.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CubitHost<LibraryScreenCubit>(
      onCreate: (cubit) => cubit.onCreate(),
      child: const LibraryScreenContent(),
    );
  }
}
