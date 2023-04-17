import '../../../../business_logic/blocs.dart';
import '../../../../data/models/models.dart';
import '../../screens.dart';
import 'backround_container.dart';
import 'menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class FoldersHome extends StatelessWidget {
  const FoldersHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child:
            BackgroundContainer(child: BlocBuilder<FoldersBloc, FoldersState>(
          builder: (builderContext, state) {
            if (state.folders == null) {
              return const SizedBox();
            }

            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: state.folders!.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                ),
                child: Divider(),
              ),
              itemBuilder: (BuildContext ctx, int index) {
                final Folder folder = state.folders![index];
                return MenuItemWidget(
                  title: folder.name,
                  number: context
                      .watch<NotesBloc>()
                      .getNotesByFolderId(folder.id!)
                      .length,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FolderScreen(folder: folder))).then((value) {
                      context.read<NotesBloc>().add(NotesStarted());
                    });
                  },
                );
              },
            );
          },
        )));
  }
}
