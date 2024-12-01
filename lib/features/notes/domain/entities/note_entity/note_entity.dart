import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_entity.freezed.dart';

@freezed
class NoteEntity with _$NoteEntity {
  const NoteEntity._();

  const factory NoteEntity({
    @Default(null) int? id,
    required DateTime creationDateTime,
    required String content,
  }) = _NoteEntity;

  factory NoteEntity.fromModel(NoteModel noteModel) {
    return NoteEntity(
        id: noteModel.id, creationDateTime: noteModel.creationDateTime, content: noteModel.content);
  }

  NoteModel toModel() {
    var noteModel = NoteModel()
      ..creationDateTime = creationDateTime
      ..content = content;

    if (id != null) {
      noteModel.id = id!;
    }

    return noteModel;
  }
}
