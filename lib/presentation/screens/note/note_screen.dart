import '../../../business_logic/blocs.dart';
import '../../../data/models/models.dart';
import '../../theme/colors.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as editor;
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;
  final int? folderId;
  const NoteScreen({Key? key, this.note, this.folderId}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  editor.QuillController _controller = editor.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      var myJSON = jsonDecode(widget.note!.description);
      _controller = editor.QuillController(
        document: editor.Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
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
        title: Text(widget.note == null ? "Create Note" : "Edit Note"),
        actions: [
          BlocConsumer<NotesBloc, NotesState>(
            listenWhen: (previous, current) => true,
            listener: (context, state) {
              if (state.runtimeType == NotesLoadSuccess) {
                SnackBar snackBar = SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Ionicons.checkbox_outline),
                      SizedBox(width: 5.0),
                      Text(
                        'Success',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  backgroundColor: Colors.green,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state.runtimeType == NotesLoadFailure) {
                SnackBar snackBar = SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Ionicons.warning_outline),
                      SizedBox(width: 5.0),
                      Text(
                        'Error',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (!isValidForm()) return;

                    final String description =
                        jsonEncode(_controller.document.toDelta().toJson());
                    if (widget.note == null) {
                      context.read<NotesBloc>().add(NotesAddPressed(
                          folderId: widget.folderId,
                          note: Note(
                              description: description,
                              title: _titleController.text)));
                    } else {
                      context.read<NotesBloc>().add(NotesUpdatePressed(
                          note: Note(
                              id: widget.note!.id,
                              description: description,
                              title: _titleController.text)));
                    }
                  },
                  icon: const Icon(
                    Ionicons.save_outline,
                    color: ColorsApp.blueLight,
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _titleController,
                maxLines: 1,
                maxLength: 34,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return 'El titulo es requerido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              editor.QuillToolbar.basic(
                  showSearchButton: false, controller: _controller),
              Expanded(
                child: editor.QuillEditor.basic(
                  controller: _controller,

                  readOnly: false, // true for view only mode
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
