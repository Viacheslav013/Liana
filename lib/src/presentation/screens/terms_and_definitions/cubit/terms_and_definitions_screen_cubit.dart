import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' as injectable;
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/domain/repository/terms_and_definitions_repository.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/cubit/terms_and_definitions_screen_state.dart';

@injectable.injectable
class TermsAndDefinitionsScreenCubit
    extends Cubit<TermsAndDefinitionsScreenState> {
  TermsAndDefinitionsScreenCubit(
    this._termsAndDefinitionsRepository,
  ) : super(const TermsAndDefinitionsScreenState());

  final TermsAndDefinitionsRepository _termsAndDefinitionsRepository;
  StreamSubscription<List<TermAndDefinition>>?
      _termsAndDefinitionsStreamSubscription;

  void onCreate(Module module) {
    _termsAndDefinitionsStreamSubscription = _termsAndDefinitionsRepository
        .getTermsAndDefinitionsByModuleId(module.id ?? -1)
        .listen(_termsAndDefinitionsListener, onError: (_) => _emitError());
  }

  void _termsAndDefinitionsListener(
    List<TermAndDefinition> termsAndDefinitions,
  ) {
    emit(
      state.copyWith(
        termsAndDefinitions: termsAndDefinitions,
        isLoading: false,
        error: null,
      ),
    );
  }

  String? validateTerm(String? term) {
    if (term == null || term.isEmpty) {
      return 'Пожалуйста, введите термин';
    }

    return null;
  }

  String? validateDefinition(String? definition) {
    if (definition == null || definition.isEmpty) {
      return 'Пожалуйста, введите определение';
    }

    return null;
  }

  Future<void> onCreateTermAndDefinition(
    TermAndDefinition termAndDefinition,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _termsAndDefinitionsRepository
          .createTermAndDefinition(termAndDefinition);
      emit(state.copyWith(isLoading: false));
    } on Object {
      _emitError();
    }
  }

  Future<void> onUpdateTermAndDefinition(
    TermAndDefinition termAndDefinition,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _termsAndDefinitionsRepository
          .updateTermAndDefinition(termAndDefinition);
      emit(state.copyWith(isLoading: false));
    } on Object {
      _emitError();
    }
  }

  Future<void> onToggleIsTermAndDefinitionFavorite(
    TermAndDefinition termAndDefinition,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final updatedTermAndDefinition = termAndDefinition.copyWith(
        isFavorite: !termAndDefinition.isFavorite,
      );
      await _termsAndDefinitionsRepository
          .updateTermAndDefinition(updatedTermAndDefinition);
      emit(state.copyWith(isLoading: false));
    } on Object {
      _emitError();
    }
  }

  Future<void> onDeleteTermAndDefinition(
    TermAndDefinition termAndDefinition,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _termsAndDefinitionsRepository
          .deleteTermAndDefinition(termAndDefinition);
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
    _termsAndDefinitionsStreamSubscription?.cancel();

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
        error: 'Упс, что-то пошло не так...',
      ),
    );
  }
}
