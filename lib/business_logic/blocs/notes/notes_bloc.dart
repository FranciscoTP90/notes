import '../../../data/models/models.dart';
import '../../../data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;
  NotesBloc(this._notesRepository) : super(const NotesInitial()) {
    on<NotesStarted>(_onNotesStared);
    on<NotesAddPressed>(_onAddPressed);
    on<NotesUpdatePressed>(_onUpdate);
    on<NotesDeletePermanentlyPressed>(_onDelete);
  }

  Future<void> _onDelete(
      NotesDeletePermanentlyPressed event, Emitter<NotesState> emit) async {
    await _notesRepository.deletePermanently(event.note);
    state.notes?.removeWhere((note) => note.id == event.note.id);

    emit(NotesLoadSuccess(noteLoad: null, noteList: state.notes));
  }

  Future<void> _onUpdate(
      NotesUpdatePressed event, Emitter<NotesState> emit) async {
    emit(NotesLoadingProgress(
        loadingNote: state.note, loadingNotes: state.notes));

    try {
      final updatedNote = await _notesRepository.updateNote(event.note);

      final List<Note> notesList = state.notes!.map((note) {
        if (note.id != updatedNote!.id) {
          return note;
        }
        return updatedNote;
      }).toList();
      emit(NotesLoadSuccess(noteLoad: updatedNote, noteList: notesList));
    } catch (e) {
      throw 'Error _onUpdate()=> $e';
    }
  }

  void _onAddPressed(NotesAddPressed event, Emitter<NotesState> emit) async {
    final note = await _notesRepository.createNote(
        event.note.title, event.note.description, event.folderId);

    final notes = [...?state.notes];
    notes.add(note!);
    emit(NotesLoadSuccess(noteLoad: note, noteList: notes));
  }

  List<Note> getNotesByStatus(NoteStatus status) {
    if (state.notes == null) {
      return [];
    } else {
      final notes =
          state.notes!.where((note) => note.status == status).toList();
      return notes;
    }
  }

  List<Note> getNotesByFolderId(int id) {
    if (state.notes == null) {
      return [];
    } else {
      final notes = state.notes!.where((note) => note.folderId == id).toList();
      return notes;
    }
  }

  void _onNotesStared(NotesStarted event, Emitter<NotesState> emit) {
    final notes = _notesRepository.getAllNotes();
    emit(NotesLoadSuccess(noteLoad: state.note, noteList: notes));
  }
}
