import '../../presentation/theme/colors.dart';
import 'models.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MenuItemModel {
  final String title;
  final Color color;
  final IconData icon;
  final NoteStatus status;

  MenuItemModel(this.title, this.color, this.icon, this.status);

  static final values = [
    MenuItemModel("All Documents", ColorsApp.blueLight, Ionicons.document,
        NoteStatus.all),
    MenuItemModel(
        "Starred", ColorsApp.yellow, Ionicons.star, NoteStatus.starred),
    MenuItemModel(
        "Archive", ColorsApp.greenLight, Ionicons.archive, NoteStatus.archive),
    MenuItemModel("Trash", ColorsApp.orange, Ionicons.trash, NoteStatus.trash),
  ];
}
