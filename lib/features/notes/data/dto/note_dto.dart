import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_dto.freezed.dart';
part 'note_dto.g.dart';

@freezed
class NoteDto with _$NoteDto {
  const factory NoteDto({
    required String id,
    required DateTime creationDateTime,
    required String content,
  }) = _NoteDto;

  factory NoteDto.fromJson(Map<String, Object?> json) => _$NoteDtoFromJson(json);
}
