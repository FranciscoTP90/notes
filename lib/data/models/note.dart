import 'models.dart';
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime createdAt;
  @HiveField(4)
  DateTime updatedAt;
  @HiveField(5)
  NoteStatus status;
  @HiveField(6)
  int? folderId;

  Note({
    this.id,
    required this.title,
    required this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.status = NoteStatus.all,
    this.folderId,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  String get updateAtFormart =>
      "${updatedAt.month}/${updatedAt.day}/${updatedAt.year} - ${updatedAt.hour}:${updatedAt.minute}:${updatedAt.second}";

  @override
  String toString() {
    return "NOTE $id - $title - $description $status";
  }

  String get statusName {
    switch (status) {
      case NoteStatus.all:
        return 'All Documents';
      case NoteStatus.archive:
        return 'Archive';
      case NoteStatus.starred:
        return 'Starred';
      case NoteStatus.trash:
        return 'Trash';
      default:
        return 'N/A';
    }
  }

  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    NoteStatus? status,
    int? folderId,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      folderId: folderId ?? this.folderId,
    );
  }
}

// enum Status { all, starred, archive, trash }
