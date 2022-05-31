// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'repository/database_repository.dart' as _i4;
import 'repository/idatabase_repository.dart' as _i3;
import 'repository/iwords_repository.dart' as _i5;
import 'repository/words_repository.dart' as _i6;
import 'service/iwords_service.dart' as _i7;
import 'service/words_service.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.IDatabaseRepository>(() => _i4.DatabaseRepository());
  gh.factory<_i5.IWordsRepository>(
      () => _i6.WordsRepository(get<_i3.IDatabaseRepository>()));
  gh.factory<_i7.IWordsService>(
      () => _i8.WordsService(get<_i5.IWordsRepository>()));
  return get;
}
