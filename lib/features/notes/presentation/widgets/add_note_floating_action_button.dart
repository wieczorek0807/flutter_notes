import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/routers/app_router.dart';

class AddNoteFloatingActionButton extends StatelessWidget {
  const AddNoteFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.router.push(const AddNoteRoute()),
      tooltip: context.appLocalizations.addNote,
      child: const Icon(Icons.add),
    );
  }
}
