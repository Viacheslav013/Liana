import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/domain/repository/terms_and_definitions_repository.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/cubit/terms_and_definitions_screen_state.dart';

@injectable
class FavoritesCubit extends Cubit<TermsAndDefinitionsScreenState> {
  FavoritesCubit(
    this._termsAndDefinitionsRepository,
  ) : super(const TermsAndDefinitionsScreenState()) {
    _termsAndDefinitionsStreamSubscription = _termsAndDefinitionsRepository
        .getFavoriteTermsAndDefinitions()
        .listen(_termsAndDefinitionsListener, onError: (_) => _emitError());
  }

  final TermsAndDefinitionsRepository _termsAndDefinitionsRepository;
  StreamSubscription<List<TermAndDefinition>>?
      _termsAndDefinitionsStreamSubscription;

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

  void onDismissError() {
    emit(state.copyWith(error: null));
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

  @override
  Future<void> close() {
    _termsAndDefinitionsStreamSubscription?.cancel();

    return super.close();
  }
}
