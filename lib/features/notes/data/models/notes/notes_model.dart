import 'package:isar/isar.dart';
part 'notes_model.g.dart';

@collection
class NotesModel {
  Id id = Isar.autoIncrement;
  DateTime? creationDateTime;
  String? content;
}
