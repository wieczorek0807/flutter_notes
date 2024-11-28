import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/routers/app_router.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';

@RoutePage()
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.appLocalizations.notes),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          return state.map(
              initial: (_) => Text('initail'),
              error: (_) => Text('error'),
              loading: (_) => Text('loading'),
              loaded: (_) => Text('loaded'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getIt<AppRouter>().push(const AddNoteRoute());
        },
        tooltip: context.appLocalizations.addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
