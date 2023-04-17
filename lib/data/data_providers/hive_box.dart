import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxProvider {
  static const String themeModeBoxName = 'themeModeBox';
  static const String noteBoxName = 'noteBox';
  static const String folderBoxName = 'folderBox';

  static Future<void> init() async {
    //PRIMERO INICIALIZO
    await Hive.initFlutter();
    //  REGISATRO LAS CLASES (VALORES PRMITIVOS NO NECESARIO)
    Hive.registerAdapter<Note>(NoteAdapter());
    Hive.registerAdapter<Folder>(FolderAdapter());
    Hive.registerAdapter<NoteStatus>(NoteStatusAdapter());
    //ABRO
    await Future.wait([
      Hive.openBox<bool>(themeModeBoxName),
      Hive.openBox<Note>(noteBoxName),
      Hive.openBox<Folder>(folderBoxName),
    ]);

    await Future.wait([_initThemeMode(), _initFolders()]);
  }

  static Future<void> _initThemeMode() async {
    try {
      final Box<bool> box = Hive.box<bool>(themeModeBoxName);
      final bool existKey = box.containsKey('darkMode');

      if (!existKey) {
        final Brightness brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;
        final bool isDarkMode = brightness == Brightness.dark;
        await box.put('darkMode', isDarkMode);
      }
    } catch (e) {
      throw 'Error _initThemeMode()=> $e';
    }
  }

  bool getThemeMode() {
    Box<bool> box = Hive.box<bool>(themeModeBoxName);
    final bool isDarkMode = box.get('darkMode')!;

    return isDarkMode;
  }

  Future<void> changeThemeMode(bool value) async {
    Box<bool> box = Hive.box<bool>(themeModeBoxName);
    await box.put('darkMode', value);
  }

  static Future<void> _initFolders() async {
    final Box<Folder> folderBox = Hive.box<Folder>(folderBoxName);
    final bool isEmpty = folderBox.isEmpty;
    try {
      if (isEmpty) {
        Folder personal = Folder(name: 'Personal', id: 0);
        Folder work = Folder(name: 'Work', id: 1);
        Folder family = Folder(name: 'Family', id: 2);
        await folderBox.addAll([personal, work, family]);
      }
    } catch (e) {
      throw 'Error _initFolders()=> $e';
    }
  }

  List<Note> getAllNotes() {
    try {
      final notes = Hive.box<Note>(noteBoxName).values.toList();
      return notes;
    } catch (e) {
      return [];
    }
  }

  Map<NoteStatus, List<Note>> getTopContainerInfo() {
    Map<NoteStatus, List<Note>> notesByStatus = {};

    for (NoteStatus status in NoteStatus.values) {
      final notes = Hive.box<Note>(noteBoxName)
          .values
          .where((note) => note.status == status)
          .toList();

      notesByStatus.addAll({status: notes});
    }

    return notesByStatus;
  }

  Future<Note?> createNote(
      String title, String description, int? folderId) async {
    final noteBox = Hive.box<Note>(noteBoxName);

    try {
      final newNote = Note(
          title: title,
          folderId: folderId,
          description: description,
          updatedAt: DateTime.now(),
          createdAt: DateTime.now());

      final key = await noteBox.add(newNote);
      newNote.id = key;

      await newNote.save();

      return newNote;
    } catch (e) {
      return null;
    }
  }

  List<Folder> getAllFolders() {
    return Hive.box<Folder>(folderBoxName).values.toList();
  }

  Future<Folder?> createFolder(String name) async {
    try {
      final Box<Folder> folderBox = Hive.box<Folder>(folderBoxName);
      final newFolder = Folder(name: name);
      final folderKey = await folderBox.add(newFolder);
      newFolder.id = folderKey;
      await newFolder.save();

      return newFolder;
    } catch (e) {
      return null;
    }
  }

  Future<Note?> updateNote(Note note) async {
    try {
      final Box<Note> noteBox = Hive.box<Note>(noteBoxName);
      Note noteToUpdate = noteBox.get(note.id)!;
      noteToUpdate.title = note.title;
      noteToUpdate.description = note.description;

      noteToUpdate.status = note.status;
      noteToUpdate.updatedAt = DateTime.now();

      await noteToUpdate.save();

      return noteToUpdate;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteNotePermanently(Note note) async {
    final noteBox = Hive.box<Note>(noteBoxName);

    await noteBox.delete(note.key);
  }

  Future<void> deleteFolder(Folder folder) async {
    try {
      final Box<Folder> folderBox = Hive.box<Folder>(folderBoxName);
      Folder? deleteFolder = folderBox.get(folder.key);
      await deleteFolder!.delete();
    } catch (e) {
      throw 'Error deleteFolder: $e';
    }
  }

  Future<Folder?> editFolder(Folder folder) async {
    try {
      final Box<Folder> folderBox = Hive.box<Folder>(folderBoxName);
      Folder? editedFolder = folderBox.get(folder.id);
      editedFolder!.name = folder.name;
      await editedFolder.save();
      return editedFolder;
    } catch (e) {
      return null;
    }
  }
}
