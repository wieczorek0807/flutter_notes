import 'package:isar/isar.dart';
part 'note_model.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  DateTime? creationDateTime;
  String? content;
}
