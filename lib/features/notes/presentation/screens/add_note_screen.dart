import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/presentation/widgets/app_default_screen.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart';

@RoutePage()
class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return AppDefaultScreen(
      title: context.appLocalizations.addNote,
      body: BlocProvider(
        create: (context) => getIt<AddNoteCubit>(),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: myController,
                minLines: 3,
                maxLines: 50,
              ),
            ),
            const SizedBox(height: 15),
            BlocConsumer<AddNoteCubit, AddNoteState>(
              builder: (context, state) {
                return state.maybeWhen(
                    submitting: () =>
                        ElevatedButton(onPressed: () {}, child: const CircularProgressIndicator()),
                    orElse: () => ElevatedButton(
                        onPressed: () {
                          context.read<AddNoteCubit>().saveNote(myController.text);
                        },
                        child: const Text('Save')));
              },
              listener: (context, state) {
                state.maybeMap(
                  orElse: () => {},
                  error: (value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(value.message),
                  )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
