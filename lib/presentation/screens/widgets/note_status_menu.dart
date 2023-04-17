import '../../../business_logic/blocs.dart';
import '../../../data/models/models.dart';
import '../../theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotesStatusMenu extends StatelessWidget {
  const NotesStatusMenu({
    Key? key,
    required this.note,
    required this.builderContext,
  }) : super(key: key);

  final Note note;
  final BuildContext builderContext;

  @override
  Widget build(BuildContext context) {
    final bool isTrashStatus = note.status == NoteStatus.trash;
    return SizedBox(
      height: isTrashStatus ? 70 : 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isTrashStatus) ...[
            const SizedBox(height: 10.0),
            const Text("Move To",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              width: 25.0,
              height: 4.0,
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                  color: ColorsApp.blueLight,
                  borderRadius: BorderRadius.circular(12.0)),
            ),
          ],
          Row(
            // crossAxisAlignment: ,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (isTrashStatus) ...[
                _NoteStatus(
                  icon: Ionicons.warning_outline,
                  color: ColorsApp.orange,
                  text: "Delete Permanently",
                  onTap: () {
                    builderContext
                        .read<NotesBloc>()
                        .add(NotesDeletePermanentlyPressed(note: note));
                  },
                ),
                _NoteStatus(
                  icon: Ionicons.refresh,
                  color: ColorsApp.greenLight,
                  text: "Restore",
                  onTap: () {
                    builderContext.read<NotesBloc>().add(NotesUpdatePressed(
                        note: note.copyWith(status: NoteStatus.all)));
                  },
                )
              ],
              if (!isTrashStatus) ...[
                _NoteStatus(
                  color: ColorsApp.blue,
                  icon: Ionicons.document,
                  onTap: () {
                    builderContext.read<NotesBloc>().add(NotesUpdatePressed(
                        note: note.copyWith(status: NoteStatus.all)));
                  },
                  text: "All Docs.",
                ),
                _NoteStatus(
                  color: ColorsApp.yellow,
                  icon: Ionicons.star,
                  onTap: () {
                    builderContext.read<NotesBloc>().add(NotesUpdatePressed(
                        note: note.copyWith(status: NoteStatus.starred)));
                  },
                  text: "Starred",
                ),
                _NoteStatus(
                  color: ColorsApp.greenLight,
                  icon: Ionicons.archive,
                  onTap: () {
                    builderContext.read<NotesBloc>().add(NotesUpdatePressed(
                        note: note.copyWith(status: NoteStatus.archive)));
                  },
                  text: "Archive",
                ),
                _NoteStatus(
                  icon: Ionicons.trash,
                  color: ColorsApp.orange,
                  text: "Trash",
                  onTap: () {
                    builderContext.read<NotesBloc>().add(NotesUpdatePressed(
                        note: note.copyWith(status: NoteStatus.trash)));
                  },
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}

class _NoteStatus extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  final Color color;
  final String text;

  const _NoteStatus(
      {Key? key,
      required this.icon,
      required this.color,
      required this.text,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 100,
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        onTap!();
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Icon(icon, color: color), Text(text)],
        ),
      ),
    );
  }
}
