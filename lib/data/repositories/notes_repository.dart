import '../data_providers/hive_box.dart';
import '../models/models.dart';

class NotesRepository {
  final HiveBoxProvider _hiveBoxProvider;

  NotesRepository(this._hiveBoxProvider);

  Map<NoteStatus, List<Note>> getTopContainerInfo() {
    return _hiveBoxProvider.getTopContainerInfo();
  }

  Future<Note?> createNote(
      String title, String description, int? folderId) async {
    final note =
        await _hiveBoxProvider.createNote(title, description, folderId);
    return note;
  }

  List<Note> getAllNotes() {
    return _hiveBoxProvider.getAllNotes();
  }

  Future<Note?> updateNote(Note note) async {
    Note? updatedNote = await _hiveBoxProvider.updateNote(note);
    return updatedNote;
  }

  Future<void> deletePermanently(Note note) async {
    await _hiveBoxProvider.deleteNotePermanently(note);
  }
}
