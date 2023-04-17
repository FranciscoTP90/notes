part of 'notes_bloc.dart';

@immutable
abstract class NotesState extends Equatable {
  final Note? note;
  final List<Note>? notes;

  const NotesState({
    this.note,
    this.notes,
  });
}

class NotesInitial extends NotesState {
  const NotesInitial() : super(note: null, notes: const <Note>[]);
  @override
  List<Object?> get props => [];
}

class NotesLoadSuccess extends NotesState {
  final Note? noteLoad;

  final List<Note>? noteList;

  const NotesLoadSuccess({required this.noteLoad, required this.noteList})
      : super(note: noteLoad, notes: noteList);

  @override
  List<Object?> get props => [noteLoad, noteList];
}

class NotesLoadFailure extends NotesState {
  final List<Note>? failureNotes;
  final Note? failureNote;

  const NotesLoadFailure(
      {required this.failureNotes, required this.failureNote})
      : super(notes: failureNotes, note: failureNote);
  @override
  List<Object?> get props => [failureNotes, failureNote];
}

class NotesLoadingProgress extends NotesState {
  final List<Note>? loadingNotes;
  final Note? loadingNote;
  const NotesLoadingProgress(
      {required this.loadingNotes, required this.loadingNote})
      : super(note: loadingNote, notes: loadingNotes);
  @override
  List<Object?> get props => [loadingNote, loadingNotes];
}
