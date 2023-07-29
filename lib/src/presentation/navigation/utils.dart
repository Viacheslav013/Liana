import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liana/src/presentation/base/cubit_host.dart';
import 'package:liana/src/presentation/navigation/platform_page_route.dart';

PageRoute<dynamic> screen(
  Widget child, {
  RouteSettings? settings,
}) {
  return platformPageRoute<dynamic>(
    settings: settings,
    builder: (c) => child,
  );
}

PageRoute<dynamic> cubitScreen<T extends Cubit<Object?>>(
  Widget child, {
  RouteSettings? settings,
  Function(T)? onCreate,
  bool lazy = false,
}) {
  return platformPageRoute<dynamic>(
    settings: settings,
    builder: (c) => CubitHost<T>(
      onCreate: onCreate,
      lazy: lazy,
      child: child,
    ),
  );
}

NavigatorState? navigator(BuildContext context) => Navigator.of(context);

NavigatorState? rootNavigator(BuildContext context) =>
  Navigator.of(context, rootNavigator: true);
