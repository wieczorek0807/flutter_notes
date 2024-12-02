import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';

@freezed
class NoteModel with _$NoteModel {
  const NoteModel._();

  const factory NoteModel({
    required String id,
    required DateTime creationDateTime,
    required String content,
  }) = _NoteModel;

  factory NoteModel.fromDto(NoteDto noteDto) {
    return NoteModel(
      id: noteDto.id,
      creationDateTime: noteDto.creationDateTime,
      content: noteDto.content,
    );
  }

  NoteDto toDto() {
    return NoteDto(id: id, creationDateTime: creationDateTime, content: content);
  }
}
