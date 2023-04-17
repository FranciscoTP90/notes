part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class NotesStarted extends NotesEvent {
  @override
  List<Object?> get props => [];
}

class NotesAddPressed extends NotesEvent {
  final Note note;
  final int? folderId;

  const NotesAddPressed({
    required this.note,
    this.folderId,
  });

  @override
  List<Object?> get props => [note, folderId];
}

class NotesUpdatePressed extends NotesEvent {
  final Note note;

  const NotesUpdatePressed({
    required this.note,
  });
  @override
  List<Object?> get props => [note];
}

class NotesDeletePermanentlyPressed extends NotesEvent {
  final Note note;
  const NotesDeletePermanentlyPressed({required this.note});

  @override
  List<Object?> get props => [note];
}
