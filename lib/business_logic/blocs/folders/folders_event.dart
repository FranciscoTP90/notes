part of 'folders_bloc.dart';

@immutable
abstract class FoldersEvent extends Equatable {
  const FoldersEvent();
}

class FoldersStared extends FoldersEvent {
  @override
  List<Object?> get props => [];
}

class FoldersCreatePressed extends FoldersEvent {
  final String folderName;

  const FoldersCreatePressed({required this.folderName});
  @override
  List<Object?> get props => [folderName];
}

class FoldersDeletePressed extends FoldersEvent {
  final Folder folder;

  const FoldersDeletePressed(this.folder);
  @override
  List<Object?> get props => [folder];
}

class FoldersEditedPressed extends FoldersEvent {
  final Folder folder;

  const FoldersEditedPressed(this.folder);
  @override
  List<Object?> get props => [folder];
}
