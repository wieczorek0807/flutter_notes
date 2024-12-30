import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/edit_note_cubit/edit_note_cubit.dart';

class EditNoteSaveButton extends StatelessWidget {
  const EditNoteSaveButton(
      {super.key, required this.controller, required this.noteEntity});
  final TextEditingController controller;
  final NoteEntity noteEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditNoteCubit, EditNoteState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const LinearProgressIndicator(),
          orElse: () => ElevatedButton(
            onPressed: () => context
                .read<EditNoteCubit>()
                .editNote(controller.text, noteEntity),
            child: Text(context.appLocalizations.save),
          ),
        );
      },
    );
  }
}
