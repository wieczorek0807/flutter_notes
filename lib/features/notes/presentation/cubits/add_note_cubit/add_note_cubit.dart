import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/routers/app_router.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/usecases/notes_usecase/notes_usecase.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'add_note_state.dart';
part 'add_note_cubit.freezed.dart';

@injectable
class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this._notesUsecase) : super(const AddNoteState.initial());

  final NotesUsecase _notesUsecase;

  Future<void> saveNote(String content) async {
    try {
      emit(const AddNoteState.submitting());
      if (content.trim().isEmpty) {
        emit(const AddNoteState.error(message: 'Note cannot be empty'));
        return;
      }

      final value = await _notesUsecase.addNote(
        noteEntity: NoteEntity(
          creationDateTime: DateTime.now(),
          content: content.trim(),
        ),
      );
      value.fold(
          (failure) => emit(
                AddNoteState.error(message: failure.message),
              ), (_) async {
        await getIt<NotesCubit>().getNotes();
        getIt<AppRouter>().maybePop();
      });
    } catch (e) {
      emit(AddNoteState.error(message: 'An error occurred: ${e.toString()}'));
    }
  }
}
