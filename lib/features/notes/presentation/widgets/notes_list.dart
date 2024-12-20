import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.noteEntities});

  final List<NoteEntity> noteEntities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: noteEntities.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(
                noteEntities[index].content,
                //?? textAlign: TextAlign.center,
              ),
              subtitle: Text(
                noteEntities[index].creationDateTime,
                textAlign: TextAlign.right,
              ),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'delete') {
                    context
                        .read<NotesCubit>()
                        .deleteNote(noteId: noteEntities[index].id);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(context.appLocalizations.delete),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
