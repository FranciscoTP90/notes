import '../../../business_logic/blocs.dart';
import '../../../data/models/models.dart';
import '../../theme/colors.dart';
import '../screens.dart';
import '../widgets/note_status_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FolderScreen extends StatefulWidget {
  final Folder folder;
  const FolderScreen({Key? key, required this.folder}) : super(key: key);

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _textController.text = widget.folder.name;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<FoldersBloc, FoldersState>(
          listener: (context, state) {
            if (state.editStatus == FolderEditStatus.success) {
              Navigator.pop(context);
              _textController.text = state.folder!.name;
            }
            if (state.deleteStatus == FolderDeleteStatus.success) {
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            }
          },
          builder: (context, state) {
            return Text(_textController.text);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Change Folder's Name"),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _textController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      actions: [
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Ionicons.close_circle_outline),
                            label: const Text("Cancel")),
                        ElevatedButton.icon(
                            onPressed: () {
                              if (!isValidForm()) return;
                              widget.folder.name = _textController.text;
                              context
                                  .read<FoldersBloc>()
                                  .add(FoldersEditedPressed(widget.folder));
                            },
                            icon: const Icon(Ionicons.checkmark_circle_outline),
                            label: const Text("Accept"))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Ionicons.create_outline)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Folder"),
                      content: const Text(
                          "Are you sure you want to permanently delete this folder?"),
                      actions: [
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Ionicons.close_circle_outline),
                            label: const Text("Cancel")),
                        ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<FoldersBloc>()
                                  .add(FoldersDeletePressed(widget.folder));
                            },
                            icon: const Icon(Ionicons.checkmark_circle_outline),
                            label: const Text("Yes, delete"))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Ionicons.trash_outline,
                color: ColorsApp.orange,
              ))
        ],
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (builderContext, state) {
          List<Note> notes =
              context.read<NotesBloc>().getNotesByFolderId(widget.folder.id!);
          if (notes.isEmpty) {
            return const Center(
              child: Text("Create your first note"),
            );
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
                          builder: (context) => NoteScreen(
                              folderId: widget.folder.id, note: note)));
                },
                onLongPress: () {
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteScreen(
                  folderId: widget.folder.id,
                ),
              ));
        },
        label: const Text("New Note"),
      ),
    );
  }
}
