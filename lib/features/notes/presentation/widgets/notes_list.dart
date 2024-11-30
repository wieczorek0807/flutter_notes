import 'package:flutter/material.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:intl/intl.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.noteEntities});

  final List<NoteEntity> noteEntities;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: noteEntities.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    noteEntities[index].content,
                    // textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(noteEntities[index].creationDateTime),
                    textAlign: TextAlign.right,
                  ),

                  // subtitleTextStyle: TextStyle(),
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
