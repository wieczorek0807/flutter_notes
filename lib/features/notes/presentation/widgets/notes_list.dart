import 'package:flutter/material.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
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
                DateFormat(context.appLocalizations.dateFormat).format(noteEntities[index].creationDateTime),
                textAlign: TextAlign.right,
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
