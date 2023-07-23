import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liana/src/di/di_widget.dart';

class CubitHost<T extends Cubit<Object?>> extends StatelessWidget {
  const CubitHost({
    required this.child,
    Key? key,
    this.onCreate,
    this.lazy = false,
  }) : super(key: key);

  final Widget child;
  final Function(T)? onCreate;
  final bool lazy;

  T _createBloc(BuildContext context) {
    if (!getIt.isRegistered<T>()) {
      throw Exception('Type $T is not marked as injectable');
    }

    final cubit = getIt.get<T>();
    onCreate?.call(cubit);

    return cubit;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: _createBloc,
      lazy: lazy,
      child: child,
    );
  }
}
