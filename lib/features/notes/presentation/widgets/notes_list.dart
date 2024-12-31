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
        return Column(
          children: [
            ListTile(
              title: Text(
                noteEntities[index].content,
                //?? textAlign: TextAlign.center,
              ),
              subtitle: Text(
                DateFormat('yyyy-MM-dd HH:mm')
                    .format(noteEntities[index].creationDateTime),
                textAlign: TextAlign.right,
              ),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'delete') {
                    context
                        .read<NotesCubit>()
                        .deleteNote(noteId: noteEntities[index].id);
                  }
                  if (value == 'modify') {
                    context.router
                        .push(EditNoteRoute(noteEntity: noteEntities[index]));
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
