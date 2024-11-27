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
    as _i6;
import '../../features/notes/data/datasources/notes_local_data_source_impl.dart'
    as _i7;
import '../../features/notes/data/repositories/notes_repository.dart' as _i8;
import '../../features/notes/data/repositories/notes_repository_impl.dart'
    as _i9;
import '../../features/notes/domain/usecases/notes_usecase/notes_usecase.dart'
    as _i10;
import '../../features/notes/domain/usecases/notes_usecase/notes_usecase_impl.dart'
    as _i11;
import '../data/database/local_database_client.dart' as _i4;
import '../data/database/local_database_client_impl.dart' as _i5;
import '../routers/app_router.dart' as _i3;

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
    gh.singleton<_i3.AppRouter>(() => _i3.AppRouter());
    gh.singleton<_i4.LocalDatabaseClient>(() => _i5.LocalDatabaseClientImpl());
    gh.factory<_i6.NotesLocalDataSource>(
        () => _i7.NotesLocalDataSourceImpl(gh<_i4.LocalDatabaseClient>()));
    gh.factory<_i8.NotesRepository>(
        () => _i9.NotesRepositoryImpl(gh<_i6.NotesLocalDataSource>()));
    gh.factory<_i10.NotesUsecase>(
        () => _i11.NotesUsecaseImpl(gh<_i8.NotesRepository>()));
    return this;
  }
}
