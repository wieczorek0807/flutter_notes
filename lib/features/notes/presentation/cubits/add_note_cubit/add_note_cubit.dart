import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'add_note_state.dart';
part 'add_note_cubit.freezed.dart';

@injectable
class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(const AddNoteState.initial());

  void dispose() {
    print('add_note_cubit_dispose');
  }
}
