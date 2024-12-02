import 'package:flutter_notes/features/notes/data/models/note_hive/note_model_hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'note_entity.freezed.dart';

@freezed
class NoteEntity with _$NoteEntity {
  const NoteEntity._();

  const factory NoteEntity({
    required String id,
    required String creationDateTime,
    required String content,
  }) = _NoteEntity;

  factory NoteEntity.fromModel(NoteModelHive noteModel) {
    return NoteEntity(
        id: noteModel.id,
        creationDateTime: DateFormat('yyyy-MM-dd HH:mm').format(noteModel.creationDateTime),
        content: noteModel.content);
  }

  NoteModelHive toModel() {
    var noteModel =
        NoteModelHive(id: id, creationDateTime: DateTime.parse(creationDateTime), content: content);

    return noteModel;
  }
}
