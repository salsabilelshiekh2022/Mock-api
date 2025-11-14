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

import '../../features/posts/data/data_sources/posts_local_data_source.dart'
    as _i326;
import '../../features/posts/data/data_sources/posts_remote_data_source.dart'
    as _i245;
import '../../features/posts/data/repos/posts_repository_impl.dart' as _i1066;
import '../../features/posts/domain/repos/posts_repository.dart' as _i1033;
import '../../features/posts/domain/use_cases/get_posts_use_case.dart' as _i78;
import '../database/cache/app_cache_helper.dart' as _i756;
import '../database/cache/cache_services.dart' as _i408;
import '../database/network/api_consumer.dart' as _i742;
import '../database/network/dio_consumer.dart' as _i1062;
import '../database/network/network_info.dart' as _i46;
import 'injection_module.dart' as _i212;

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
    final injectionModule = _$InjectionModule();
    gh.factory<_i973.InternetConnectionChecker>(
        () => injectionModule.internetConnectionChecker);
    gh.lazySingleton<_i756.AppCacheHelper>(() => _i756.AppCacheHelper());
    gh.lazySingleton<_i408.CacheServices>(() => _i408.CacheServices());
    gh.lazySingleton<_i46.NetworkInfo>(() => _i46.NetworkInfoImpl(
        internetConnectionChecker: gh<_i973.InternetConnectionChecker>()));
    gh.lazySingleton<_i326.PostsLocalDataSource>(
        () => _i326.PostsLocalDataSourceImpl(gh<_i408.CacheServices>()));
    gh.lazySingleton<_i742.ApiConsumer>(
        () => _i1062.DioConsumer(appCacheHelper: gh<_i756.AppCacheHelper>()));
    gh.lazySingleton<_i245.PostsRemoteDataSource>(
        () => _i245.PostsRemoteDataSourceImpl(
              gh<_i742.ApiConsumer>(),
              gh<_i408.CacheServices>(),
            ));
    gh.lazySingleton<_i1033.PostsRepository>(() => _i1066.PostsRepositoryImpl(
          remoteDataSource: gh<_i245.PostsRemoteDataSource>(),
          localDataSource: gh<_i326.PostsLocalDataSource>(),
          networkInfo: gh<_i46.NetworkInfo>(),
        ));
    gh.factory<_i78.GetPostsUseCase>(
        () => _i78.GetPostsUseCase(gh<_i1033.PostsRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i212.InjectionModule {}
