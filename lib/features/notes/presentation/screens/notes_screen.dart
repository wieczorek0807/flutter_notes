import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/presentation/widgets/app_default_screen.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:flutter_notes/features/notes/presentation/widgets/add_note_floating_action_button.dart';
import 'package:flutter_notes/features/notes/presentation/widgets/notes_list.dart';

@RoutePage()
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDefaultScreen(
        title: context.appLocalizations.notes,
        body: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            return state.when(
              initial: () => Text(context.appLocalizations.addFirstNote),
              error: (message) =>
                  Text(context.appLocalizations.errorScreenMessage(message)),
              loaded: (noteEntitiesList) =>
                  NotesList(noteEntities: noteEntitiesList),
              loading: () => const CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: const AddNoteFloatingActionButton());
  }
}
