import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notes_state.dart';
part 'notes_cubit.freezed.dart';

@singleton
class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState.initial());

  void dispose() {
    print('notes_cubit_dispose');
  }
}
