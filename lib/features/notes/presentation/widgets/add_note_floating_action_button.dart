import 'package:flutter/material.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/routers/app_router.dart';

class AddNoteFloatingActionButton extends StatelessWidget {
  const AddNoteFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => getIt<AppRouter>().push(const AddNoteRoute()),
      tooltip: context.appLocalizations.addNote,
      child: const Icon(Icons.add),
    );
  }
}
