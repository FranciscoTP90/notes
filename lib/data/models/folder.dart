import 'package:hive/hive.dart';

part 'folder.g.dart';

@HiveType(typeId: 2)
class Folder extends HiveObject {
  @HiveField(0)
  late int? id;
  @HiveField(1)
  late String name;

  Folder({required this.name, this.id});

  @override
  String toString() {
    return 'FOLDER: $id $name';
  }
}
