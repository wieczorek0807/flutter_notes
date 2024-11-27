import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';

@RoutePage()
class NewNoteScreen extends StatelessWidget {
  const NewNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.appLocalizations.addNote),
      ),
      body: const Center(
        child: Text('note TextForm'),
      ),
    );
  }
}
