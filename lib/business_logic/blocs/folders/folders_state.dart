part of 'folders_bloc.dart';

enum FoldersStatus { initial, loadSuccess }

enum FolderCreateStatus {
  initial,
  loading,
  success,
  failure,
}

enum FolderEditStatus {
  initial,
  loading,
  success,
  failure,
}

enum FolderDeleteStatus {
  initial,
  loading,
  success,
  failure,
}

class FoldersState extends Equatable {
  final Folder? folder;
  final List<Folder>? folders;
  final FoldersStatus status;
  final FolderCreateStatus createStatus;
  final FolderEditStatus editStatus;
  final FolderDeleteStatus deleteStatus;
  const FoldersState(
      {this.folder,
      this.folders,
      this.status = FoldersStatus.initial,
      this.createStatus = FolderCreateStatus.initial,
      this.editStatus = FolderEditStatus.initial,
      this.deleteStatus = FolderDeleteStatus.initial});

  @override
  List<Object?> get props =>
      [folder, folders, status, createStatus, editStatus, deleteStatus];

  FoldersState copyWith(
      {Folder? folder,
      List<Folder>? folders,
      FoldersStatus? status,
      FolderCreateStatus? createStatus,
      FolderEditStatus? editStatus,
      FolderDeleteStatus? deleteStatus}) {
    return FoldersState(
        folder: folder ?? this.folder,
        folders: folders ?? this.folders,
        status: status ?? this.status,
        createStatus: createStatus ?? this.createStatus,
        editStatus: editStatus ?? this.editStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus);
  }
}
