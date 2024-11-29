import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/presentation/widgets/app_default_screen.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:flutter_notes/features/notes/presentation/widgets/add_note_floating_action_button.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDefaultScreen(
        title: context.appLocalizations.notes,
        body: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return state.map(
              initial: (_) => const Text('initail'),
              error: (_) => const Text('error'),
              loading: (_) => const Text('loading'),
              loaded: (state) => SizedBox(
                width: double.infinity,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(scrollbars: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.noteEntitiesList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              state.noteEntitiesList[index].content,
                              // textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              DateFormat('yyyy-MM-dd HH:mm')
                                  .format(state.noteEntitiesList[index].creationDateTime),
                              textAlign: TextAlign.right,
                            ),
                
                            // subtitleTextStyle: TextStyle(),
                          ),
                          if (index != state.noteEntitiesList.length - 1) const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: const AddNoteFloatingActionButton());
  }
}
