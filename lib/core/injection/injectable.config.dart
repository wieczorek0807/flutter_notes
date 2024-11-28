// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/notes/data/datasources/notes_local_data_source.dart'
    as _i7;
import '../../features/notes/data/datasources/notes_local_data_source_impl.dart'
    as _i8;
import '../../features/notes/data/repositories/notes_repository.dart' as _i9;
import '../../features/notes/data/repositories/notes_repository_impl.dart'
    as _i10;
import '../../features/notes/domain/usecases/notes_usecase/notes_usecase.dart'
    as _i11;
import '../../features/notes/domain/usecases/notes_usecase/notes_usecase_impl.dart'
    as _i12;
import '../../features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart'
    as _i3;
import '../../features/notes/presentation/cubits/notes_cubit/notes_cubit.dart'
    as _i13;
import '../data/database/local_database_client.dart' as _i5;
import '../data/database/local_database_client_impl.dart' as _i6;
import '../routers/app_router.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AddNoteCubit>(() => _i3.AddNoteCubit());
    gh.singleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.singleton<_i5.LocalDatabaseClient>(() => _i6.LocalDatabaseClientImpl());
    gh.factory<_i7.NotesLocalDataSource>(
        () => _i8.NotesLocalDataSourceImpl(gh<_i5.LocalDatabaseClient>()));
    gh.factory<_i9.NotesRepository>(
        () => _i10.NotesRepositoryImpl(gh<_i7.NotesLocalDataSource>()));
    gh.factory<_i11.NotesUsecase>(
        () => _i12.NotesUsecaseImpl(gh<_i9.NotesRepository>()));
    gh.singleton<_i13.NotesCubit>(
        () => _i13.NotesCubit(gh<_i11.NotesUsecase>()));
    return this;
  }
}
