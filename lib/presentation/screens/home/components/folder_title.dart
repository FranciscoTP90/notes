import '../../../../business_logic/blocs.dart';
import '../../../theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FolderTitle extends StatelessWidget {
  const FolderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Folders",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          _CreateFolderButton(),
        ],
      ),
    );
  }
}

class _CreateFolderButton extends StatefulWidget {
  const _CreateFolderButton({
    Key? key,
  }) : super(key: key);

  @override
  State<_CreateFolderButton> createState() => _CreateFolderButtonState();
}

class _CreateFolderButtonState extends State<_CreateFolderButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _textController.dispose();
  }

  bool isValidForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoldersBloc, FoldersState>(
      listener: (context, state) {
        _textController.text = '';
        switch (state.createStatus) {
          case FolderCreateStatus.success:
            SnackBar snackBar = SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Ionicons.checkbox_outline),
                  SizedBox(width: 5.0),
                  Text(
                    'Folder created',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              backgroundColor: ColorsApp.greenLight,
            );
            Future.delayed(const Duration(milliseconds: 300)).then((value) {
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });

            break;
          case FolderCreateStatus.failure:
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
              backgroundColor: ColorsApp.orange,
            );
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
          default:
        }
      },
      builder: (builderContext, state) {
        bool isLoading = state.status == FolderCreateStatus.loading;
        return IconButton(
          icon: const Icon(Ionicons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Create Folder"),
                  content: Form(
                      key: _formKey,
                      child: TextFormField(
                        maxLength: 30,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _textController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Folder name'),
                      )),
                  actions: [
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(ColorsApp.orange)),
                        onPressed: () {
                          _textController.text = '';
                          Navigator.pop(context);
                        },
                        icon: const Icon(Ionicons.close_circle_outline),
                        label: const Text("Cancel")),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ColorsApp.greenLight)),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (!isValidForm()) return;
                                FocusScope.of(context).unfocus();

                                // log("ON TAP ${state.folder} ${state.folders?.length} ${state.status}");
                                builderContext.read<FoldersBloc>().add(
                                    FoldersCreatePressed(
                                        folderName: _textController.text));
                              },
                        icon: const Icon(Ionicons.checkmark_circle_outline),
                        label: Text(isLoading ? "Accept..." : "Accept")),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
