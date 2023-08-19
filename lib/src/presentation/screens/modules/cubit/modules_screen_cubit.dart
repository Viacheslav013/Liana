import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/domain/repository/modules_repository.dart';
import 'package:liana/src/presentation/screens/modules/cubit/modules_screen_state.dart';

@injectable.injectable
class ModulesScreenCubit extends Cubit<ModulesScreenState> {
  ModulesScreenCubit(
    this._modulesRepository,
  ) : super(const ModulesScreenState());

  final ModulesRepository _modulesRepository;
  StreamSubscription<List<Module>>? _modulesStreamSubscription;

  void onCreate(Folder folder) {
    _modulesStreamSubscription = _modulesRepository
        .getModulesByFolderId(folder.id ?? -1)
        .listen(_modulesListener, onError: (_) => _emitError());
  }

  void _modulesListener(List<Module> modules) {
    emit(
      state.copyWith(
        modules: modules,
        isLoading: false,
        error: null,
      ),
    );
  }

  String? validateModuleName(String? name) {
    if (name == null || name.isEmpty) {
      return 'modules_screen_empty_module_name_error'.tr();
    }

    return null;
  }

  Future<void> onCreateModule(Module module) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _modulesRepository.createModule(module);
      emit(state.copyWith(isLoading: false));
    } on Object {
      _emitError();
    }
  }

  Future<void> onUpdateModule(Module module) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _modulesRepository.updateModule(module);
      emit(state.copyWith(isLoading: false));
    } on Object {
      _emitError();
    }
  }

  Future<void> onDeleteModule(Module module) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _modulesRepository.deleteModule(module);
      emit(state.copyWith(isLoading: false));
    } on Object {
      _emitError();
    }
  }

  void onDismissError() {
    emit(state.copyWith(error: null));
  }

  @override
  Future<void> close() {
    _modulesStreamSubscription?.cancel();

    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    _emitError();
    super.onError(error, stackTrace);
  }

  void _emitError() {
    emit(
      state.copyWith(
        isLoading: false,
        error: 'default_error_message'.tr(),
      ),
    );
  }
}
