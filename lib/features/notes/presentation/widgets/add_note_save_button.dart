import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/presentation/values/values.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart';

class AddNoteSaveButton extends StatelessWidget {
  const AddNoteSaveButton({super.key, required this.controller});
  final TextEditingController controller;

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNoteCubit, AddNoteState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const LinearProgressIndicator(),
          orElse: () => ElevatedButton(
            onPressed: () => context.read<AddNoteCubit>().saveNote(controller.text),
            child: Text(context.appLocalizations.save),
          ),
        );
      },
      listener: (context, state) {
        state.maybeWhen(
          error: (message) => _showErrorSnackBar(context, message),
          orElse: () {},
        );
      },
    );
  }
}
