import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model_hive.freezed.dart';

@freezed
class NoteModelHive with _$NoteModelHive {
  const NoteModelHive._();

  const factory NoteModelHive({
    required String id,
    required DateTime creationDateTime,
    required String content,
  }) = _NoteModelHive;

  factory NoteModelHive.fromDto(NoteDto noteDto) {
    return NoteModelHive(
      id: noteDto.id,
      creationDateTime: noteDto.creationDateTime,
      content: noteDto.content,
    );
  }

  NoteDto toDto() {
    return NoteDto(id: id, creationDateTime: creationDateTime, content: content);
  }
}
