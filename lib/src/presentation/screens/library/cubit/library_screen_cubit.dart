import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/repository/folders_repository.dart';
import 'package:liana/src/presentation/screens/library/cubit/library_screen_state.dart';

@injectable
class LibraryScreenCubit extends Cubit<LibraryScreenState> {
  LibraryScreenCubit(
    this._foldersRepository,
  ) : super(const LibraryScreenState());

  final FoldersRepository _foldersRepository;
  StreamSubscription<List<Folder>>? _foldersStreamSubscription;

  void onCreate() {
    _foldersStreamSubscription = _foldersRepository
        .getAllFolders()
        .listen(_foldersListener, onError: (_) => emitError());
  }

  void _foldersListener(List<Folder> folders) {
    emit(
      state.copyWith(
        folders: folders,
        isLoading: false,
        error: null,
      ),
    );
  }

  String? validateFolderName(String? name) {
    if (name == null || name.isEmpty) {
      return 'library_screen_empty_folder_name_error'.tr();
    }

    return null;
  }

  Future<void> onCreateFolder(Folder folder) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _foldersRepository.createFolder(folder);
      emit(state.copyWith(isLoading: false));
    } on Object {
      emitError();
    }
  }

  Future<void> onUpdateFolder(Folder folder) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _foldersRepository.updateFolder(folder);
      emit(state.copyWith(isLoading: false));
    } on Object {
      emitError();
    }
  }

  Future<void> onDeleteFolder(Folder folder) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _foldersRepository.deleteFolder(folder);
      emit(state.copyWith(isLoading: false));
    } on Object {
      emitError();
    }
  }

  void onDismissError() {
    emit(state.copyWith(error: null));
  }

  @override
  Future<void> close() {
    _foldersStreamSubscription?.cancel();

    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    emitError();
  }

  void emitError() {
    emit(
      state.copyWith(
        isLoading: false,
        error: 'default_error_message'.tr(),
      ),
    );
  }
}
