import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:liana/src/di/di_widget.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<GetIt> _configureDependencies() async => getIt.init();

class DiWidget extends StatelessWidget {
  const DiWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _configureDependencies(),
      builder: (_, snapshot) => snapshot.hasData ? child : Container(),
    );
  }
}
