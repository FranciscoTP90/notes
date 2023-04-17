import 'package:hive/hive.dart';
part 'status.g.dart';

@HiveType(typeId: 1)
enum NoteStatus {
  @HiveField(0)
  all,
  @HiveField(1)
  starred,
  @HiveField(2)
  archive,
  @HiveField(3)
  trash
}
