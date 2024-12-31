import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/routers/app_router.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:intl/intl.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.noteEntities});

  final List<NoteEntity> noteEntities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: noteEntities.length,
      itemBuilder: (context, index) {
        final note = noteEntities[index];
        return Column(
          children: [
            ListTile(
              title: Text(noteEntities[index].content),
              subtitle: Text(
                textAlign: TextAlign.right,
                DateFormat('yyyy-MM-dd HH:mm')
                    .format(noteEntities[index].creationDateTime),
              ),
              trailing: _buildPopupMenuButton(context, note),
              isThreeLine: true,
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}

Widget _buildPopupMenuButton(BuildContext context, NoteEntity note) {
  return PopupMenuButton<String>(
    onSelected: (value) {
      switch (value) {
        case 'delete':
          context.read<NotesCubit>().deleteNote(noteId: note.id);
          break;
        case 'modify':
          context.router.push(EditNoteRoute(noteEntity: note));
          break;
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'delete',
        child: Text(context.appLocalizations.delete),
      ),
      PopupMenuItem(
        value: 'modify',
        child: Text(context.appLocalizations.modify),
      ),
    ],
  );
}
