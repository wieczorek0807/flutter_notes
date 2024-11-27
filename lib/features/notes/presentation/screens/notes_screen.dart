import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/routers/app_router.dart';

@RoutePage()
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Notes'),
      ),
      body: const Center(
        child: Text('notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getIt<AppRouter>().push(const NewNoteRoute());
        },
        tooltip: 'Add new note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
