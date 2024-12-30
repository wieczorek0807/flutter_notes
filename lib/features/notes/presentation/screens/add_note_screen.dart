import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/presentation/values/values.dart';
import 'package:flutter_notes/core/presentation/widgets/app_default_screen.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:flutter_notes/features/notes/presentation/widgets/add_note_save_button.dart';

import '../widgets/note_content_form.dart';

@RoutePage()
class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        content: Text(message),
      ),
    );
  }

  void _success(BuildContext context) {
    context.read<NotesCubit>().getNotes();
    context.router.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return AppDefaultScreen(
      title: context.appLocalizations.addNote,
      body: BlocProvider(
        create: (context) => getIt<AddNoteCubit>(),
        child: BlocListener<AddNoteCubit, AddNoteState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) => _showErrorSnackBar(context, message),
              success: () => _success(context),
              orElse: () {},
            );
          },
          child: Column(
            children: [
              NoteContentForm(controller: controller, formKey: formKey),
              const SizedBox(height: AppDimensions.spacerHeight),
              AddNoteSaveButton(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
