import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      topAppBar: platformTopAppBar(
        title: const Text('Библиотека'),
      ),
      body: const Center(
        child: Text('Библиотека'),
      ),
    );
  }
}
