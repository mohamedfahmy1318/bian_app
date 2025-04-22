// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../../features/main/pages/manager/main_cubit.dart' as _i489;
import '../../features/tabs/azkar/data/data_sources/remote_azkar_data_source.dart'
    as _i443;
import '../../features/tabs/azkar/data/repositories/azkar_repo_imp.dart'
    as _i255;
import '../../features/tabs/azkar/domain/repositories/azkar_repository.dart'
    as _i492;
import '../../features/tabs/azkar/domain/use_cases/wakingUp_from_Sleep_azkar_use_case.dart'
    as _i170;
import '../../features/tabs/azkar/presentation/manager/cubit/azkar_cubit.dart'
    as _i545;
import '../../features/tabs/prayer/data/data_sources/remote_prayer_times_data_Sourse.dart'
    as _i794;
import '../../features/tabs/prayer/data/repositories/prayer_times_repo_imp.dart'
    as _i1070;
import '../../features/tabs/prayer/domain/repositories/prayer_times_repo.dart'
    as _i539;
import '../../features/tabs/prayer/domain/use_cases/prayer_time_use_case.dart'
    as _i71;
import '../../features/tabs/prayer/presentation/manager/cubit/prayer_times_cubit.dart'
    as _i674;
import '../../features/tabs/sebha/data/data_sources/local_sebha_data_source.dart'
    as _i24;
import '../../features/tabs/sebha/data/repositories/sebha_repository_impl.dart'
    as _i146;
import '../../features/tabs/sebha/domain/repositories/sebha_repository.dart'
    as _i702;
import '../../features/tabs/sebha/domain/use_cases/get_sebha_count_use_case.dart'
    as _i258;
import '../../features/tabs/sebha/domain/use_cases/increment_sebha_use_case.dart'
    as _i1027;
import '../../features/tabs/sebha/domain/use_cases/reset_sebha_use_case.dart'
    as _i419;
import '../../features/tabs/sebha/presentation/manager/sebha_cubit.dart'
    as _i49;
import '../api/dio_client.dart' as _i861;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i861.ApiManager>(() => _i861.ApiManager());
    gh.singleton<_i24.LocalSebhaDataSource>(() => _i24.LocalSebhaDataSource());
    gh.factory<_i702.SebhaRepository>(
        () => _i146.SebhaRepositoryImpl(gh<_i24.LocalSebhaDataSource>()));
    gh.factory<_i1027.IncrementSebhaUseCase>(
        () => _i1027.IncrementSebhaUseCase(gh<_i702.SebhaRepository>()));
    gh.factory<_i489.ConnectivityCubit>(() => _i489.ConnectivityCubit(
        checker: gh<_i973.InternetConnectionChecker>()));
    gh.factory<_i258.GetSebhaCountUseCase>(
        () => _i258.GetSebhaCountUseCase(gh<_i702.SebhaRepository>()));
    gh.factory<_i419.ResetSebhaUseCase>(
        () => _i419.ResetSebhaUseCase(gh<_i702.SebhaRepository>()));
    gh.factory<_i49.SebhaCubit>(
        () => _i49.SebhaCubit(gh<_i702.SebhaRepository>()));
    gh.factory<_i794.RemotePrayerTimesDataSource>(
        () => _i794.RemotePrayerTimesDataSourceImp(gh<_i861.ApiManager>()));
    gh.factory<_i443.RemoteAzkarDataSource>(
        () => _i443.RemoteAzkarDataSourceImpl(gh<_i861.ApiManager>()));
    gh.factory<_i539.PrayerTimesRepo>(() =>
        _i1070.PrayerTimesRepoImp(gh<_i794.RemotePrayerTimesDataSource>()));
    gh.factory<_i492.AzkarRepository>(
        () => _i255.AzkarRepositoryImpl(gh<_i443.RemoteAzkarDataSource>()));
    gh.factory<_i71.PrayerTimeUseCase>(
        () => _i71.PrayerTimeUseCase(gh<_i539.PrayerTimesRepo>()));
    gh.factory<_i170.GetAzkarByCategoryUseCase>(
        () => _i170.GetAzkarByCategoryUseCase(gh<_i492.AzkarRepository>()));
    gh.factory<_i170.GetAllAzkarCategoriesUseCase>(
        () => _i170.GetAllAzkarCategoriesUseCase(gh<_i492.AzkarRepository>()));
    gh.factory<_i674.PrayerTimesCubit>(
        () => _i674.PrayerTimesCubit(gh<_i71.PrayerTimeUseCase>()));
    gh.factory<_i545.AzkarCubit>(() => _i545.AzkarCubit(
          gh<_i170.GetAllAzkarCategoriesUseCase>(),
          gh<_i170.GetAzkarByCategoryUseCase>(),
        ));
    return this;
  }
}
