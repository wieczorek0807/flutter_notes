import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:flutter_notes/features/notes/presentation/screens/notes_screen.dart';

@RoutePage()
class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.appLocalizations.addNote),
      ),
      body: BlocProvider(
        create: (context) => getIt<AddNoteCubit>(),
        child: BlocBuilder<AddNoteCubit, AddNoteState>(
          builder: (context, state) {
            return state.map(
                initial: (_) => Text('initail'),
                error: (_) => Text('error'),
                submitting: (_) => Text('submitting'),
                success: (_) => Text('success'));
          },
        ),
      ),
    );
  }
}
