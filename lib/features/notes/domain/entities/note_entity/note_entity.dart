import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

part 'note_entity.freezed.dart';

@freezed
class NoteEntity with _$NoteEntity {
  const NoteEntity._();

  const factory NoteEntity({
    required String id,
    required String creationDateTime,
    required String content,
  }) = _NoteEntity;

  factory NoteEntity.createNewNote({
    required String content,
  }) {
    return NoteEntity(
      id: const Uuid().v1(),
      creationDateTime: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
      content: content.trim(),
    );
  }

  factory NoteEntity.fromModel(NoteModel noteModel) {
    return NoteEntity(
        id: noteModel.id,
        creationDateTime:
            DateFormat('yyyy-MM-dd HH:mm').format(noteModel.creationDateTime),
        content: noteModel.content);
  }

  NoteModel toModel() {
    var noteModel = NoteModel(
        id: id,
        creationDateTime: DateTime.parse(creationDateTime),
        content: content);

    return noteModel;
  }
}
