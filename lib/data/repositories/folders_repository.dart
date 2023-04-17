import '../data_providers/hive_box.dart';
import '../models/models.dart';

class FoldersRepository {
  final HiveBoxProvider _hiveBoxProvider;
  FoldersRepository(this._hiveBoxProvider);

  List<Folder> getAllFolders() {
    return _hiveBoxProvider.getAllFolders();
  }

  Future<Folder?> createFolder(String name) async {
    return await _hiveBoxProvider.createFolder(name);
  }

  Future<void> deleteFolder(Folder folder) async {
    await _hiveBoxProvider.deleteFolder(folder);
  }

  Future<Folder?> editFolder(Folder folder) async {
    final editedFolder = await _hiveBoxProvider.editFolder(folder);
    return editedFolder;
  }
}
