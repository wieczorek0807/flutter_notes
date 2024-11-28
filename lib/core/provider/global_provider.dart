import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<NotesCubit>()),
    ], child: child);
  }
}
