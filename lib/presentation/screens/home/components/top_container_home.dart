import '../../../../business_logic/blocs.dart';
import '../../../../data/models/models.dart';
import '../../screens.dart';
import 'backround_container.dart';
import 'menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class TopContainerHome extends StatelessWidget {
  const TopContainerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: BackgroundContainer(
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state.notes == null) {
                return const SizedBox();
              }
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MenuItemModel.values.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Divider(),
                ),
                itemBuilder: (context, index) {
                  final item = MenuItemModel.values[index];

                  return MenuItemWidget(
                    title: item.title,
                    number: context
                        .read<NotesBloc>()
                        .getNotesByStatus(item.status)
                        .length,
                    iconColor: item.color,
                    icon: item.icon,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteListScreen(
                              title: item.title,
                              status: item.status,
                            ),
                          ));
                    },
                  );
                },
              );
            },
          ),
        ));
  }
}
