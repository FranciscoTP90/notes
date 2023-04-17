import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
part 'folders_event.dart';
part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  final FoldersRepository _foldersRepository;
  FoldersBloc(this._foldersRepository) : super(const FoldersState()) {
    on<FoldersStared>(_onFolderStared);
    on<FoldersCreatePressed>(_onFoldersCreate);
    on<FoldersDeletePressed>(_onDelete);
    on<FoldersEditedPressed>(_onEdit);
  }

  _onEdit(FoldersEditedPressed event, Emitter<FoldersState> emit) async {
    try {
      emit(state.copyWith(editStatus: FolderEditStatus.loading));
      final Folder? editedFolder =
          await _foldersRepository.editFolder(event.folder);
      emit(state.copyWith(
          folder: editedFolder!, editStatus: FolderEditStatus.success));
    } catch (e) {
      emit(state.copyWith(editStatus: FolderEditStatus.failure));
    }
  }

  Future<void> _onDelete(
      FoldersDeletePressed event, Emitter<FoldersState> emit) async {
    try {
      emit(state.copyWith(deleteStatus: FolderDeleteStatus.loading));
      await _foldersRepository.deleteFolder(event.folder);
      state.folders!.removeWhere((folder) => folder.id == event.folder.id);

      emit(state.copyWith(
          folders: state.folders,
          folder: null,
          deleteStatus: FolderDeleteStatus.success));
    } catch (e) {
      emit(state.copyWith(deleteStatus: FolderDeleteStatus.failure));
    }
  }

  _onFolderStared(FoldersStared event, Emitter<FoldersState> emit) {
    final folders = _foldersRepository.getAllFolders();

    emit(state.copyWith(
      status: FoldersStatus.loadSuccess,
      folders: folders,
    ));
  }

  void _onFoldersCreate(
      FoldersCreatePressed event, Emitter<FoldersState> emit) async {
    try {
      emit(state.copyWith(createStatus: FolderCreateStatus.loading));

      final folder = await _foldersRepository.createFolder(event.folderName);

      List<Folder> folderList = [...?state.folders];

      folderList.add(folder!);
      emit(state.copyWith(
          folder: folder,
          folders: folderList,
          createStatus: FolderCreateStatus.success));
    } catch (e) {
      emit(state.copyWith(createStatus: FolderCreateStatus.failure));
    }
  }
}
