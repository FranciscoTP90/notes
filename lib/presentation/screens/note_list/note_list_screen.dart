import '../../../business_logic/blocs.dart';
import '../../../data/models/models.dart';
import '../screens.dart';
import '../widgets/note_status_menu.dart';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NoteListScreen extends StatelessWidget {
  final NoteStatus status;
  final String title;

  const NoteListScreen({Key? key, required this.status, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (builderContext, state) {
            if (state.notes == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final notes = context.read<NotesBloc>().getNotesByStatus(status);

            if (notes.isEmpty) {
              return const Center(child: Text("No notes"));
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                final Note note = notes[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteScreen(note: note)))
                        .then((value) {});
                  },
                  onLongPress: () {
                    log("SHOW MENU ${note.folderId}");
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return NotesStatusMenu(
                            note: note, builderContext: builderContext);
                      },
                    );
                  },
                  title: Text(note.title),
                  subtitle: Text(note.updateAtFormart),
                  trailing: const Icon(Ionicons.chevron_forward),
                );
              },
            );
          },
        ));
  }
}
